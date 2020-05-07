class Scorecard < ApplicationRecord
  belongs_to :round
  has_one :golfer, through: :round, class_name: "User"
  validates :hole_number, :strokes, :putts, presence: true

  def par
    self.round.course.tees.find_by(color: self.round.tee).holes.find_by(hole_number: self.hole_number).par
  end

  def yardage
    self.round.course.tees.find_by(color: self.round.tee).holes.find_by(hole_number: self.hole_number).yardage
  end

end
