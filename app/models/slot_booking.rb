class SlotBooking < ApplicationRecord
  belongs_to :user
  belongs_to :slot

  validates :slot_id, uniqueness: { scope: :user_id, message: "has already been booked by you" }
end
