class Hole < ApplicationRecord
  belongs_to :tee
  has_one :course, through: :tee

  validates :hole_number, :par, :yardage, presence: true
  validates :lid, uniqueness: { message: ": Hole numbers cannot be the same" } 
  validate :hole_in_range

  before_validation :set_lid

  def rounds
    rounds = Round.arel_table
    Round.where(rounds[:course_id].eq(self.course.id)
      .and(rounds[:tee].eq(self.tee.color)))
  end

  def scores
    scores = Scorecard.arel_table
    Scorecard.where(scores[:round_id].in(self.rounds.pluck(:id))
      .and(scores[:hole_number].eq(self.hole_number))).order(:strokes).limit(5)
  end

  private

  def hole_in_range
    if hole_number && (hole_number < 1 || hole_number > 18)
      errors.add(:hole_number, "must be between 1 and 18")
    end
  end
  
  def set_lid
    self.lid = "#{self.tee.course.id}#{self.tee.color}#{self.hole_number}"
  end

end
