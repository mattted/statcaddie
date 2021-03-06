class Round < ApplicationRecord
  belongs_to :golfer, class_name: "User"
  belongs_to :course
  has_many :scorecards, dependent: :destroy
  has_many :tees, through: :course
  has_many :holes, through: :tees

  validates :date, :tee, presence: true

  accepts_nested_attributes_for :scorecards, allow_destroy: true, reject_if: :all_blank

  def total
    self.scorecards.sum(:strokes)
  end

  def par
    self.scorecards.sum(:par)
  end

  def style
    self.course.style
  end

  def total_putts
    self.scorecards.sum(:putts)
  end

  def total_gir
    self.scorecards.where(gir: true).count
  end

  def total_fairways
    self.scorecards.where(fairway: true).count
  end

  def over_under_num
    self.total - self.par
  end

  def over_under
    ou = self.total - self.par
    if ou > 0
      "+#{ou}"
    elsif ou == 0
      "E"
    else
      ou
    end
  end

  def datef
    self.date.strftime("%-m/%-d/%Y")
  end

end
