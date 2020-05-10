class Hole < ApplicationRecord
  belongs_to :tee
  has_one :course, through: :tee
  validates :hole_number, :par, :yardage, presence: true
  before_save :set_lid

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
  
  def set_lid
    self.lid = "#{self.tee.course.id}#{self.tee.color}#{self.hole_number}"
  end

end
