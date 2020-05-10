class Scorecard < ApplicationRecord
  belongs_to :round
  has_one :golfer, through: :round, class_name: "User"
  validates :hole_number, :strokes, :putts, presence: true
  before_save :set_lid

  def par
    # self.round.course.tees.find_by(color: self.round.tee).holes.find_by(hole_number: self.hole_number).par
    Hole.find_by(lid: self.lid).par
  end

  def yardage
    # self.round.course.tees.find_by(color: self.round.tee).holes.find_by(hole_number: self.hole_number).yardage
    Hole.find_by(lid: self.lid).yardage
  end

  def over_under_num
    self.strokes - self.par
  end

  def over_under
    ou = self.strokes - self.par
    if ou > 0
      "+#{ou}"
    elsif ou == 0
      "E"
    else
      ou
    end
  end

  def set_lid
    self.lid = "#{self.round.course.id}#{self.round.tee}#{self.hole_number}"
  end

end
