class Tee < ApplicationRecord
  belongs_to :course, optional: true
  has_many :holes, dependent: :destroy
  has_many :rounds, through: :course
  validates :color, presence: true

  accepts_nested_attributes_for :holes, allow_destroy: true, reject_if: :all_blank

  def par
    self.holes.pluck(:par).sum
  end

  def yardage
    self.holes.pluck(:yardage).sum
  end

  def rounds
    rounds = Round.arel_table
    Round.where(rounds[:course_id].eq(self.course.id)
      .and(rounds[:tee].eq(self.color)))
  end

  def lowest_rounds
    self.rounds.sort_by(&:total)
  end

end
