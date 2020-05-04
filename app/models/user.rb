class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :rounds, foreign_key: :golfer_id
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
end
