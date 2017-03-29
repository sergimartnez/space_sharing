class SharedRentalsController < ApplicationController
  def view
    binding.pry
    redirect_to(:root) if params[:search_ids].nil?
    # @chatroom = Chatroom.new
    @renting_partners = User.joins(:searches).where("searches.id IN (?)", params[:search_ids])
    @shared_searches = Search.where("id IN (?)", params[:search_ids])
  end

  def create
    @shared_rental = SharedRental.new 
    @chatroom = Chatroom.new
    if @chatroom.save && @shared_rental.save
      flash[:success] = 'Chat room added!'
      redirect_to chatrooms_path
    else
      render 'new'
    end
  end
end
