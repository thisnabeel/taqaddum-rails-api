class Menteeship < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :club_members, as: :memberable, dependent: :destroy
  has_many :clubs, through: :club_members
end
