class SlotSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :status, :description, :title, :timezone, :offering, :skill, :user_id, :mentees
  has_one :user, if: -> { instance_options[:include_user] }
  has_one :meeting_offering
  has_many :mentees, serializer: UserSerializer, if: -> { instance_options[:include_mentees] }

  def offering
    object.meeting_offering
  end

  def skill
    object.mentorship.skill
  end
end
