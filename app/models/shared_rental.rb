class SharedRental < ApplicationRecord
  has_many :searches
  has_one :space

  
end
