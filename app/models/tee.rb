class Tee < ApplicationRecord
  belongs_to :course, optional: true
  has_many :holes, dependent: :destroy
  has_many :rounds, through: :course
  validates :color, presence: true

  accepts_nested_attributes_for :holes, allow_destroy: true

end
