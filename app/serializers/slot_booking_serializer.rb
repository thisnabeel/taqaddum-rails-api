class SlotBookingSerializer < ActiveModel::Serializer
  attributes :id, :status, :booking_date
  has_one :user
  has_one :slot
end
