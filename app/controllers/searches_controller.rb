require 'app_operations'

class SearchesController < ApplicationController

  def my_searches
    @my_searches = current_user.searches
  end

  def show
    @my_search = Search.find_by(id: params[:id])
    gon.lat=@my_search.latitude
    gon.long=@my_search.longitude
    @my_search_times = AppOperations.get_times_from_matrix @my_search.array_of_desired_times
    # binding.pry
  end

  def new
    @my_search = Search.new
  end

  def create
    @search = current_user.searches.new(search_params)
    if @search.save
      week_array = []
      Search::WEEK_DAYS.each do |week_day|
        week_array.push(
          AppOperations.get_day_array_of_desired_times(
            Integer(params[:start_time]["#{week_day}"]), 
            Integer(params[:end_time]["#{week_day}"])
          )
        )
      end
      @search.store_array_of_desired_times week_array
      redirect_to @search
    else
      render "new"
    end
  end

  def edit

  end

  def update
    
  end

  def searching
    @search_around = params[:search_around]
    @q = Search.ransack(params[:q])
  end

  def results

    week_array=[]
    Search::WEEK_DAYS.each do |week_day|
      week_array.push(
        AppOperations.get_day_array_of_desired_times(
          Integer(params[:start_time]["#{week_day}"]),
          Integer(params[:end_time]["#{week_day}"])
        )
      )
    end
    
    searches = Search.all # Filter the active ones and non owned by requester
    
    if params[:search_around]
      @search_around = params[:search_around]
      coords = Geocoder.coordinates(@search_around)
      searches = searches.near([coords[1], coords[0]], 25, :units => :km)
    end

    @q = searches.ransack(params[:q])
    @search_results = @q.result(distinct: true)
    # Filter results by compatibility with the search requested
    @search_results = @search_results.select{ |search| !search.is_compatible?(week_array).nil? }
    
    search_combinations = AppOperations.get_compatible_combinations_of_elements(@search_results, week_array)
    # @search_results.push(*search_combinations)
    @print = search_combinations[1]
    binding.pry
    render layout: 'index'

    # VERSION 1 !!
 
    # combinations_of_searches = Search.get_combinations_of_searches 3, current_user
    # @search_results = []
    # combinations_of_searches.each_with_index do |comb, index| 
    #   result = Search.get_compatibilities comb, week_array
    #   if result != nil
    #     percentage=AppOperations.get_percentage_of_compatibility result
    #     comb_result = Hash.new
    #     comb_result[:people] = AppOperations.parse_ids_to_names comb
    #     comb_result[:percentage] = percentage
    #     comb_result[:used_times] = AppOperations.get_times_from_matrix result
    #     @search_results.push(comb_result)
    #   end
    # end
    # @total_results=@search_results.length

    # @search_results=@search_results.sort_by{|k| k[:percentage]}.reverse
    #                                .paginate(:page => params[:page], :per_page => 5)
    # render layout: 'index'

    # VERSION 2 !! --> BY JACOBO

    # Filer the possible valid searches
        # active --> true

    # Search.get_compatible_renting_searches week_array

  end

  private
  def search_params
    params.require(:search).permit(
      :space_type,
      :title,
      :description,
      :country,
      :address_1,
      :address_2,
      :city,
      :postal_code,
      :province,
      :longitude,
      :latitude
    )
  end

end
