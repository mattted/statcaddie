class Course < ApplicationRecord
  has_many :rounds
  has_many :golfers, through: :rounds
  has_many :tees, dependent: :destroy
  has_many :holes, through: :tees
  belongs_to :creator, class_name: "User", optional: true

  scope :by_state, -> { order(:state, :city) }
  scope :pub, -> { where(access: 'Public') }
  scope :priv, -> { where(access: 'Private') }
  scope :spriv, -> { where(access: 'Semi-private') }
  scope :res, -> { where(access: 'Resort') }
  scope :desert, -> { where(style: 'Desert') }
  scope :links, -> { where(style: 'Links') }
  scope :parkland, -> { where(style: 'Parkland') }

  validates :name, :city, :state, :style, :access, presence: true

  def best_rounds
    self.rounds.sort_by(&:over_under)
  end

end
