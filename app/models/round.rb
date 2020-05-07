class Round < ApplicationRecord
  belongs_to :golfer, class_name: "User"
  belongs_to :course
  has_many :scorecards, dependent: :destroy

  validates :date, :tee, presence: true

  accepts_nested_attributes_for :scorecards, allow_destroy: true, reject_if: :all_blank

end
