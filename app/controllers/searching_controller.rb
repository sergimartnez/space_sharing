require 'search_operations'
require 'app_operations'

class SearchingController < ApplicationController
  
  def new
    @my_search = Search.new
  end

  def index
    week_array=[]
    Search::WEEK_DAYS.each do |week_day|
      week_array.push(
        SearchOperations.get_day_array_of_desired_times(
          Integer(params[:start_time]["#{week_day}"]),
          Integer(params[:end_time]["#{week_day}"])
        )
      )
    end

    combinations_of_searches = Search.get_combinations_of_searches 3, current_user
    @search_results = []
    combinations_of_searches.each_with_index do |comb, index| 
      result = Search.get_compatibilities comb, week_array
      if result != nil
        percentage=AppOperations.get_percentage_of_compatibility result
        comb_result = Hash.new
        comb_result[:people] = AppOperations.parse_ids_to_names comb
        comb_result[:percentage] = percentage
        comb_result[:used_times] = AppOperations.get_times_from_matrix result
        @search_results.push(comb_result)
      end
    end
    render layout: 'index'
  end
end
