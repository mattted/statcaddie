class Hole < ApplicationRecord
  belongs_to :tee
  has_many :rounds, through: :tee

  validates :hole_number, :par, :yardage, presence: true

end

