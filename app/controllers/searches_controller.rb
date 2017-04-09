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
    @week_array=[]
    if params[:search_array]
      # User is re-doing the search
      7.times do |i|
        @week_array.push(params[:search_array][i].split(" ").map(&:to_i))
      end
    else
      # New search from home view
      Search::WEEK_DAYS.each do |week_day|
        @week_array.push(
          AppOperations.get_day_array_of_desired_times(
            Integer(params[:start_time]["#{week_day}"]),
            Integer(params[:end_time]["#{week_day}"])
          )
        )
      end
    end

    # Filter the active ones and non owned by requester
    searches = Search.ransack(active_eq: true).result
    
    if current_user
      searches = searches.ransack(user_id_not_eq: current_user.id).result
    end               
    
    # Flter the results by geolocation --> 15 km distance max
    if params[:search_around]
      @search_around = params[:search_around]
      coords_req = Geocoder.coordinates(@search_around)
      searches = searches.near([coords_req[1], coords_req[0]], 15, :units => :km)
    end

    # Filter by any other attributes --> space_type
    @q = searches.ransack(params[:q])
    @search_results = @q.result(distinct: true)
    

    # Filter results by compatibility (time) with the search being requested
    @search_results = @search_results.select{ |search| !search.is_compatible?(@week_array).nil? }
    puts "yeah 0"
    search_combinations = AppOperations.get_compatible_combinations_of_elements(@search_results, @week_array)
    puts "yeah 2"
    # @search_results.push(*search_combinations)
    @print_results = search_combinations[1]
    # binding.pry
    gon.marker_locations = search_combinations[2]
    binding.pry
    gon.coords_req = coords_req
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
