class Round < ApplicationRecord
  belongs_to :golfer, class_name: "User"
  belongs_to :course
  has_many :scorecards, dependent: :destroy

  validates :date, presence: true

end
