class Mentorship < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :slots

  has_many :meeting_offerings, dependent: :destroy
end
