class Space < ApplicationRecord
	has_one 	:search
	belongs_to 	:user
end
