class Slot < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_offering, optional: true
  belongs_to :mentorship, optional: true

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
