class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  belongs_to :shared_rental
  validates :topic, presence: true, uniqueness: true, case_sensitive: false
end
