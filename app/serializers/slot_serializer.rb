class SlotSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :status, :description, :title, :timezone, :offering, :skill, :user_id
  has_one :user
  has_one :meeting_offering

  def offering
    object.meeting_offering
  end

  def skill
    object.mentorship.skill
  end
end
