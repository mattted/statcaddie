class Round < ApplicationRecord
  belongs_to :golfer, class_name: "User"
  belongs_to :course
  has_many :scorecards, dependent: :destroy
  has_many :tees, through: :course
  has_many :holes, through: :tees

  validates :date, :tee, presence: true

  accepts_nested_attributes_for :scorecards, allow_destroy: true, reject_if: :all_blank

  def total
    self.scorecards.pluck(:strokes).sum
  end

  def par
    self.course.tees.find_by(color: self.tee).par
  end

  def datef
    self.date.strftime("%-m/%-d/%Y")
  end

end
