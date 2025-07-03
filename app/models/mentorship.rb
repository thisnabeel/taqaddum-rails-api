class Mentorship < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :slots
  has_many :club_members, as: :memberable, dependent: :destroy
  has_many :clubs, through: :club_members

  has_many :meeting_offerings, dependent: :destroy
end
