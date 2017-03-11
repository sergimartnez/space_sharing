class SearchesController < ApplicationController

  def index
    @my_searches = current_user.searches
  end

  def show
    @my_space = Search.find_by(id: params[:id])
  end

  def new
    @my_search = Search.new
  end

  def create
    @search = current_user.searches.new(space_type: params[])
    if @search.save
      week_array = []
      Search::WEEK_DAYS.each do |week_day|
        week_array.push(SearchOperations.store_day_array_of_desired_times(
          Integer(params[:start_time]["#{week_day}"]), 
          Integer(params[:end_time]["#{week_day}"])
        ))
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

  def space_params
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
