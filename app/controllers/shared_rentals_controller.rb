require 'app_operations'
require 'gon'

class SharedRentalsController < ApplicationController
  def view
    
    redirect_to(:root) if params[:search_ids].nil?
    # @chatroom = Chatroom.new
    @renting_partners = User.joins(:searches).where("searches.id IN (?)", params[:search_ids])
    @print_info = []
    gon.coords = []
    Search.where("id IN (?)", params[:search_ids]).each do |shared_search|
      info = Hash.new
      info[:person]=shared_search.user
      info[:search]=shared_search
      info[:desired_times]=AppOperations.get_times_from_matrix shared_search.array_of_desired_times

      gon.coords.push([shared_search.longitude, shared_search.latitude])
      @print_info.push(info)
    end

    render layout: 'normal-header'
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
