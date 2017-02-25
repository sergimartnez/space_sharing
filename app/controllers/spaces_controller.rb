class SpacesController < ApplicationController
  
  def index
    @my_spaces=current_user.spaces
  end

  def new
    @my_space = current_user.spaces.new
  end

  def create
    @space = current_user.spaces.new(space_params)
    if @space.save
      redirect_to "/spaces/#{@space.id}"
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
    params.require(:space).permit(
      :type_of_space, 
      :description, 
      :space_dimensions,
      :space_capacity
    )
  end
end
