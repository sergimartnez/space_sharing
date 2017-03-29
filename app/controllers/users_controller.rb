class UsersController < ApplicationController
	before_action :authenticate_user!, :except => [:home]
	def home 

	end

  def show
   @user = User.find_by(id: params[:id]) 
  end
end
