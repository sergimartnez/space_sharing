class Space < ApplicationRecord
	has_one 	  :search
	belongs_to 	:user
  serialize   :availability, Array

  TYPES = ['Garage', 'Classroom', 'Fitness Room', 'Meetings Room', 'Rehearsal Space']

  def get_space_availability
    self.search.array_of_desired_times.map do |day_array|
      prev_val=0
      day_array.each.with_index.inject("") do |mem, (val, ind)|
        if prev_val==0 && val==1
          if mem==""
            mem=mem + "From " + ind.to_s + ":00"
          else
            mem=mem + " and from " + ind.to_s + ":00"
          end
          prev_val = 1
        elsif prev_val==1 && val==0
          mem=mem + " to " + ind.to_s + ":00"
          prev_val = 0
        end
        mem
      end
    end
  end

end
