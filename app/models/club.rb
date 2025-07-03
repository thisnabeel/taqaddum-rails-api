class Club < ApplicationRecord
  has_many :club_members, dependent: :destroy
  has_many :mentorships, through: :club_members, source: :memberable, source_type: 'Mentorship'
  has_many :menteeships, through: :club_members, source: :memberable, source_type: 'Menteeship'

  validates :title, presence: true

  def mentors
    User.joins(:mentorships).where(mentorships: { id: mentorships.pluck(:id) })
  end

  def mentees
    User.joins(:menteeships).where(menteeships: { id: menteeships.pluck(:id) })
  end
end
