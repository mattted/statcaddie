class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :rounds, foreign_key: :golfer_id
  has_many :scorecards, through: :rounds
  has_many :courses, through: :rounds
  has_many :created_courses, foreign_key: :creator_id, class_name: "Course"

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.name = auth.info.name
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def best_rounds
    self.rounds.sort_by(&:over_under_num).first(5)
  end

  def best_holes
    self.scorecards.sort_by(&:over_under_num).first(5)
  end

  def best_tee
     
  end

  def average_round
    ((self.rounds.map(&:total).sum / self.scorecards.count.to_f) * 18).round(2)
  end

  def average_score
    ou =self.rounds.map(&:over_under_num).sum / self.rounds.count.to_f
    if ou > 0
      "+#{ou}"
    elsif ou == 0
      "E"
    else
      ou
    end
  end

  def average_putts
    ((self.rounds.map(&:total_putts).sum / self.scorecards.count.to_f) * 18).round(2)
  end

  def average_fairways
    ((self.rounds.map(&:total_fairways).sum / self.scorecards.count.to_f) * 18).round(2)
  end

end
