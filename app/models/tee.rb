class Tee < ApplicationRecord
  belongs_to :course, optional: true
  has_many :holes, dependent: :destroy
  has_many :rounds, through: :course
  validates :color, presence: true

end
