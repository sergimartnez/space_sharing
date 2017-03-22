require 'rails_helper'
require 'app_operations'
require 'search_operations'

class SearchTest < ActiveSupport::TestCase
  describe "SearchOperations" do
    it "returns bla bla bla 1" do
      time_array = SearchOperations.get_day_array_of_desired_times(10, 14)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 10:00 to 14:00"
      )
    end

    it "returns bla bla bla 2" do
      time_array = SearchOperations.get_day_array_of_desired_times(0, 4)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 0:00 to 4:00"
      )
    end

    it "returns bla bla bla 3" do
      time_array = SearchOperations.get_day_array_of_desired_times(17, 24)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 17:00 to 24:00"
      )
    end

    it "returns bla bla bla 4" do
      time_array = SearchOperations.get_day_array_of_desired_times(20, 4)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 0:00 to 4:00 and from 20:00 to 24:00"
      )
    end

    it "returns bla bla bla 4" do
      time_array = SearchOperations.get_day_array_of_desired_times(15, 10)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 0:00 to 10:00 and from 15:00 to 24:00"
      )
    end

    it "Reverse matrix values" do
      time_array = SearchOperations.get_day_array_of_desired_times(10, 15)
      matrix = Array.new(7, time_array)
      expect(AppOperations.reverse_matrix_values(matrix)).to eq(
        Array.new(7, [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1])
      )
    end
  end
end