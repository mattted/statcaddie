class Scorecard < ApplicationRecord
  belongs_to :round

  validates :hole_number, :strokes, :putts, presence: true

end
