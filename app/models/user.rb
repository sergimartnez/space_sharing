class User < ApplicationRecord
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :spaces
  has_many :searches
  has_many :shared_rentals, through: :searches
  has_one  :address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: {:medium => "300x300>", :thumb => "100x100>"}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true

  
  # validates :username, presence: true, uniqueness: true
  

  def get_full_name
    self.name+" "+self.surname
  end
end
