class Course < ApplicationRecord
  has_many :rounds
  has_many :golfers, through: :rounds
  # has_many :tees, dependent: :destroy
  # has_many :holes, through: :tees
  belongs_to :creator, class_name: "User", optional: true

  validates :name, presence: true 

end
