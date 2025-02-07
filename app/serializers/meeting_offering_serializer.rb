class MeetingOfferingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :duration, :position, :max_attendees, :min_attendees, :mentorship

  def mentorship
    return MentorshipSerializer.new(object.mentorship, include_user: true)
  end
end
