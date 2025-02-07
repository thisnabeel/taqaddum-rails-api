class UserAvailability < ApplicationRecord
  belongs_to :user
  validates :day, :start_time, :end_time, :timezone, presence: true
end