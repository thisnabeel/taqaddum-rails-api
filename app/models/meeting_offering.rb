class MeetingOffering < ApplicationRecord
  belongs_to :mentorship
  has_one :user, through: :mentorship
  has_many :slots, dependent: :destroy

  validates :title, presence: true
  validates :duration, inclusion: { in: [30, 60, 90, 120], message: "must be 30, 60, 90, or 120 minutes" }
  validates :max_attendees, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true
  validates :min_attendees, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true

  before_create :set_defaults

  private

  def set_defaults
    self.max_attendees ||= 6
    self.min_attendees ||= 1
  end
end
