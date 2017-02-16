class DaySearchItem < ApplicationRecord
	belongs_to :search

	serialize 	:array_of_desired_times, Array

	def store_day_array_of_desired_times
		day_array = Array.new(24, 0)
		if !self.end_hour.nil? & !self.start_hour.nil?
			if self.end_hour < self.start_hour
				day_array[self.start_hour..23] = [1]*((23)- self.start_hour)
				if self.end_hour != 0
					day_array[0..(self.end_hour - 1)] = [1]*(self.end_hour)
				end
			else
				day_array[self.start_hour..(self.end_hour - 1)] = [1]*(self.end_hour-self.start_hour)
			end
		end
		self.array_of_desired_times = day_array
		self.save
	end
end
