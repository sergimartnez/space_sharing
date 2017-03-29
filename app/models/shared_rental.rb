class SharedRental < ApplicationRecord
  has_many :searches
  has_one :space, optional: true
  has_one :chatroom, required: true
  
end
