class Address < ApplicationRecord
  belongs_to :user
  belongs_to :space
  belongs_to :search
end
