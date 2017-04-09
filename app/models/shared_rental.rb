class SharedRental < ApplicationRecord
  has_many :searches
  has_one :space
  has_one :chatroom
  
end
