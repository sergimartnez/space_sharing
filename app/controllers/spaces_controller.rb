require 'pry'
require 'gon'
require 'search_operations'
require 'app_operations'

class SpacesController < ApplicationController
  
  def index
    @my_spaces=Space.where(user_id: current_user.id)
  end

  def show
    @space=Space.find_by(id: params[:id])
    gon.lat=@space.latitude
    gon.long=@space.longitude

    @space_availability = AppOperation.get_times_from_matrix @space.availability

  end

  def new
    @my_space = current_user.spaces.new
  end

  def create
    @space = current_user.spaces.new(space_params)
    if @space.save
      if @space.full_availability == false
        week_array = []
        Search::WEEK_DAYS.each do |week_day|
          week_array.push(
            SearchOperations.store_day_array_of_desired_times(
              Integer(params[:end_time]["#{week_day}"]), 
              Integer(params[:start_time]["#{week_day}"])
            )
          )
        end

        @space.availability = AppOperation.reverse_matrix_values week_array
        binding.pry
        @space.save
        @search = Search.new(description: params[:description],
                             space_type: params[:type_of_space],
                             array_of_desired_times: week_array,
                             space: @space,
                             user: current_user)
        if @search.save
          redirect_to "/spaces/#{@space.id}"
        else
          render "new"
        end
      else
        render "new"
      end
    else
      render "new"
    end
  end

  def edit
    @space=Space.find_by(id: params[:id])
  end

  def update

  end

  private
  def space_params
    params.require(:space).permit(
      :title,
      :type_of_space, 
      :description, 
      :space_dimensions,
      :space_capacity,
      :address_1,
      :address_2,
      :country,
      :postal_code,
      :province,
      :longitude,
      :latitude,
      :city,
      :full_availability
    )
  end
end
