class Space < ApplicationRecord
	has_one 	  :search
	belongs_to 	:user
  has_one     :address

  TYPES = ['Garage', 'Classroom', 'Fitness Room', 'Meetings Room', 'Rehearsal Space']

end
