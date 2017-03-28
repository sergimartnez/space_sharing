require 'faker'
require 'rails_helper'
require 'app_operations'

class SearchTest < ActiveSupport::TestCase
  describe "SearchOperations 1" do
    it "returns bla bla bla 1" do
      time_array = AppOperations.get_day_array_of_desired_times(10, 14)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 10:00 to 14:00"
      )
    end

    it "returns bla bla bla 2" do
      time_array = AppOperations.get_day_array_of_desired_times(0, 4)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 0:00 to 4:00"
      )
    end

    it "returns bla bla bla 3" do
      time_array = AppOperations.get_day_array_of_desired_times(17, 24)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 17:00 to 24:00"
      )
    end

    it "returns bla bla bla 4" do
      time_array = AppOperations.get_day_array_of_desired_times(20, 4)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 0:00 to 4:00 and from 20:00 to 24:00"
      )
    end

    it "returns bla bla bla 5" do
      time_array = AppOperations.get_day_array_of_desired_times(15, 10)
      expect(AppOperations.get_times_from_daily_array(time_array)).to eq(
        "From 0:00 to 10:00 and from 15:00 to 24:00"
      )
    end

    it "Reverse matrix values" do
      time_array = AppOperations.get_day_array_of_desired_times(10, 15)
      matrix = Array.new(7, time_array)
      expect(AppOperations.reverse_matrix_values(matrix)).to eq(
        Array.new(7, [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1])
      )
    end

    it "check array generation base on start time and end time 1" do
      expect(AppOperations.get_day_array_of_desired_times(10, 14)).to eq(
        [0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0]
      )
    end

    it "check array generation base on start time and end time 2" do
      expect(AppOperations.get_day_array_of_desired_times(0, 4)).to eq(
        [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      )
    end

    it "check array generation base on start time and end time 3" do
      expect(AppOperations.get_day_array_of_desired_times(20, 24)).to eq(
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1]
      )
    end

    it "check array generation base on start time and end time 4" do
      expect(AppOperations.get_day_array_of_desired_times(20, 10)).to eq(
        [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1]
      )
    end
    it "check array generation base on start time and end time 5" do
      expect(AppOperations.get_day_array_of_desired_times(23, 2)).to eq(
        [1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
      )
    end

    it "check array generation base on start time and end time 6" do
      expect(AppOperations.get_day_array_of_desired_times(24, 8)).to eq(
        [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      )
    end

    it "check array generation base on start time and end time 7" do
      expect(AppOperations.get_day_array_of_desired_times(0, 8)).to eq(
        [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      )
    end
    it "Create some searchs and check compatibilities - Case 1" do
      time_array = AppOperations.get_day_array_of_desired_times(10, 11)
      search_matrix = Array.new(7, time_array)
      searches_list=[]
      
      desired_times = Array.new(7, AppOperations.get_day_array_of_desired_times(1, 5))
      space_type = "Garage"
      search1 = Search.create!(space_type: space_type,
                 array_of_desired_times: desired_times)

      searches_list.push(search1)

      desired_times = Array.new(7, AppOperations.get_day_array_of_desired_times(15, 21))
      space_type = "Garage"
      search2 = Search.create!(space_type: space_type,
                 array_of_desired_times: desired_times)

      searches_list.push(search2)

      desired_times = Array.new(7, AppOperations.get_day_array_of_desired_times(21, 23))
      space_type = "Garage"
      search3 = Search.create!(space_type: space_type,
                 array_of_desired_times: desired_times)

      searches_list.push(search3)

      AppOperations.get_compatible_combinations_of_elements searches_list

      expect(AppOperations.get_compatible_combinations_of_elements searches_list).to eq(
        [[search1,search2],[search1,search3],[search2,search3]]
      )
      
    end
    it "Create some searchs and check compatibilities - Case 2" do
      time_array = AppOperations.get_day_array_of_desired_times(10, 11)
      search_matrix = Array.new(7, time_array)
      searches_list=[]
      
      desired_times = Array.new(7, AppOperations.get_day_array_of_desired_times(1, 5))
      space_type = "Garage"
      search1 = Search.create!(space_type: space_type,
                 array_of_desired_times: desired_times)

      searches_list.push(search1)

      desired_times = Array.new(7, AppOperations.get_day_array_of_desired_times(4, 7))
      space_type = "Garage"
      search2 = Search.create!(space_type: space_type,
                 array_of_desired_times: desired_times)

      searches_list.push(search2)

      desired_times = Array.new(7, AppOperations.get_day_array_of_desired_times(10, 20))
      space_type = "Garage"
      search3 = Search.create!(space_type: space_type,
                 array_of_desired_times: desired_times)

      searches_list.push(search3)

      AppOperations.get_compatible_combinations_of_elements searches_list

      expect(AppOperations.get_compatible_combinations_of_elements searches_list).to eq(
        [[search1,search3],[search2,search3]]
      )
      
    end
  end
end