class Slot < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_offering, optional: true
  belongs_to :mentorship, optional: true
  has_many :slot_bookings

  # Specify the class name and adjust for STI
  has_many :mentees, through: :slot_bookings, source: :user, class_name: 'Mentee'

  validates :start_time, :end_time, presence: true
  validates :status, inclusion: { in: %w[open denied] }

  scope :open, -> { where(status: 'open') }
  scope :denied, -> { where(status: 'denied') }

  def confirm!
    update!(status: 'open')
  end

  def block!
    update!(status: 'denied')
  end
end
