class Skill < ApplicationRecord
  has_many :mentorships
  has_many :mentors, through: :mentorships, source: :user

  has_many :menteeships
  has_many :mentees, through: :menteeships, source: :user
end
