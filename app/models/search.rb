class Search < ApplicationRecord
	belongs_to 	:user
	belongs_to 	:space, optional: true
	has_many 		:day_search_items

	serialize 	:array_of_desired_times, Array

	def store_array_of_desired_times
		week_array = Array.new(7, 0)
		self.day_search_items.each do |day_search|
			self.array_of_desired_times.push(day_search.array_of_desired_times)
		end
		self.save
	end

	def search_space_sharing_results user
		combinations_of_users = get_combinations_of_users 3, user
		search_results = []
		combinations_of_users.each_with_index do |comb, index| 
			result = get_compatibilities comb
			if result != nil
				percentage=TimeCompatibilityAppOp.get_percentage_of_compatibility result
				comb_result = Hash.new
				comb_result[:people] = parse_ids_to_names comb
				comb_result[:percentage] = percentage
				comb_result[:used_times] = TimeCompatibilityAppOp.get_times_from_matrix result
				search_results.push(comb_result)
			end
		end
		return search_results
	end

	def get_combinations_of_users max_combination, user
		(2..max_combination).flat_map{|size| @@user_ids.combination(size).find_all{|array| (array.include? user.id)}.uniq}
	end

	def get_compatibilities comb
		result_matrix = comb.reduce(nil) do |memo_matrix, user_id|
			actual_user = @@users.find {|user| user.id==user_id}
			actual_matrix = actual_user.desired_times_matrix
			memo_matrix = TimeCompatibilityAppOp.sum_two_matrices memo_matrix, actual_matrix
			valid = TimeCompatibilityAppOp.check_matrix_compatibility memo_matrix
			if !valid
				return nil
			end
			memo_matrix
		end
		result_matrix	
	end
end
