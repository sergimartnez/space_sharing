require 'app_operations'

class Search < ApplicationRecord
	belongs_to 	:user
	belongs_to 	:space, optional: true
	belongs_to  :shared_rental, optional: true
	has_one			:address
	serialize 	:array_of_desired_times, Array

	geocoded_by :full_address
	after_validation :geocode

	TYPES = ['Garage', 'Classroom', 'Fitness Room', 'Meetings Room', 'Rehearsal Space']
	WEEK_DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

	def full_address
		[country, city, address_1, address_2].compact.join(',')
	end

	def store_array_of_desired_times array_searches
		self.array_of_desired_times=array_searches
		self.save
	end

	def is_compatible? desired_array
		result_times_matrix = AppOperations.sum_matrices self.array_of_desired_times, desired_array
		if AppOperations.check_matrix_compatibility result_times_matrix
			return nil
		else
			return result_times_matrix
		end
	end

	def self.get_combinations_of_searches max_combination, current_user
		(1..(max_combination-1)).flat_map{|size|
			Search.all.ids.combination(size).find_all {|array| 
				(array & current_user.searches.ids).empty?
			}.uniq
		}
	end

	def self.get_compatibilities comb, search_array
		result_matrix = comb.reduce(nil) do |memo_matrix, search_id|
			actual_matrix = Search.find_by(id: search_id).array_of_desired_times
			memo_matrix = AppOperation.sum_two_matrices memo_matrix, actual_matrix
			valid = AppOperation.check_matrix_compatibility memo_matrix
			if !valid
				return nil
			end
			memo_matrix
		end
		result_matrix	= AppOperation.sum_two_matrices result_matrix, search_array
		if AppOperation.check_matrix_compatibility result_matrix
			return result_matrix
		end
	end

	def is_compatible? desired_array
		result_times_matrix = AppOperations.sum_matrices self.array_of_desired_times, desired_array
		if AppOperations.check_matrix_compatibility result_times_matrix
			return nil
		else
			return result_times_matrix
		end
	end
end
