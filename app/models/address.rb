class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :space, optional: true
  belongs_to :search, optional: true
end
