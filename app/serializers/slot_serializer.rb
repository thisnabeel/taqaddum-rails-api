class SlotSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :status
  has_one :user
  has_one :meeting_offering
end
