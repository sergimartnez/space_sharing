class SearchesController < ApplicationController

  def index
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
          SearchOperations.get_day_array_of_desired_times(
            Integer(params[:start_time]["#{week_day}"]), 
            Integer(params[:end_time]["#{week_day}"])
          )
        )
      end
      @search.store_array_of_desired_times week_array
      redirect_to "/searches/#{@search.id}"
    else
      render "new"
    end
  end

  def edit

  end

  def update

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
