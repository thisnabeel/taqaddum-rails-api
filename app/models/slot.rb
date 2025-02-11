class Slot < ApplicationRecord
  belongs_to :user
  belongs_to :meeting_offering

  validates :start_time, :end_time, presence: true
  validates :status, inclusion: { in: %w[pending confirmed blocked] }

  scope :available, -> { where(status: 'pending') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :blocked, -> { where(status: 'blocked') }

  def confirm!
    update!(status: 'confirmed')
  end

  def block!
    update!(status: 'blocked')
  end
end
