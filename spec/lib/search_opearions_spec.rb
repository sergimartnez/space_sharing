require 'rails_helper'
require 'search_operations'

class SearchTest < ActiveSupport::TestCase
  describe "SearchOperations" do
    it "check array generation base on start time and end time 1" do
      expect(SearchOperations.get_day_array_of_desired_times(10, 14)).to eq(
        [0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0]
      )
    end

    it "check array generation base on start time and end time 2" do
      expect(SearchOperations.get_day_array_of_desired_times(0, 4)).to eq(
        [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      )
    end

    it "check array generation base on start time and end time 3" do
      expect(SearchOperations.get_day_array_of_desired_times(20, 24)).to eq(
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1]
      )
    end

    it "check array generation base on start time and end time 4" do
      expect(SearchOperations.get_day_array_of_desired_times(20, 10)).to eq(
        [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1]
      )
    end
    it "check array generation base on start time and end time 5" do
      expect(SearchOperations.get_day_array_of_desired_times(23, 2)).to eq(
        [1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
      )
    end

    it "check array generation base on start time and end time 6" do
      expect(SearchOperations.get_day_array_of_desired_times(24, 8)).to eq(
        [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      )
    end

    it "check array generation base on start time and end time 7" do
      expect(SearchOperations.get_day_array_of_desired_times(0, 8)).to eq(
        [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      )
    end
  end
end
