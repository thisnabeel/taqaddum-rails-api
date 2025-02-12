class Slot < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_offering

  validates :start_time, :end_time, presence: true
  validates :status, inclusion: { in: %w[locked denied] }

  scope :locked, -> { where(status: 'locked') }
  scope :denied, -> { where(status: 'denied') }

  def confirm!
    update!(status: 'locked')
  end

  def block!
    update!(status: 'denied')
  end
end
