class Scorecard < ApplicationRecord
  belongs_to :round
  has_one :golfer, through: :round, class_name: "User"
  validates :hole_number, :strokes, :putts, presence: true
  before_save :set_lid
  before_save :set_hole_atts

  scope :hole_in_one, -> { where(strokes: 1) }
  scope :albatross, -> { where(strokes: 2, par: 5) }
  scope :eagle, -> { where("strokes = 2 AND par = 4 OR strokes = 3 AND par = 5") }
  scope :birdie, -> { where("par - strokes = 1") }
  scope :parr, -> { where("par = strokes") }
  scope :bogey, -> { where("strokes - par = 1") }
  scope :double_bogey, -> { where("strokes - par = 2") }

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

  def set_hole_atts
    self.par = Hole.find_by(lid: self.lid).par
    self.yardage = Hole.find_by(lid: self.lid).yardage
  end
end
