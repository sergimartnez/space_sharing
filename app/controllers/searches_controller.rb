class SearchesController < ApplicationController

  def index
    @my_searches = current_user.searches
  end

  def show
    @my_space = Search.get_by(id: params[:id])
  end

  def new
    @search = Search.new
    @day_search_items = Array.new(7) { DaySearchItem.new }
  end

  def create

  end

  def edit

  end

  def update

  end

end
