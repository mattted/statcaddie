class Tee < ApplicationRecord
  belongs_to :course, optional: true
  has_many :holes, dependent: :destroy
  has_many :rounds, through: :course
  validates :color, presence: true

  # TODO: Custom validation for adding holes
  # 9 or 18 holes only? Only colors that don't exist already?
  accepts_nested_attributes_for :holes, allow_destroy: true, reject_if: :all_blank

end
