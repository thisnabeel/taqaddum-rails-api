# app/serializers/mentorship_serializer.rb
class MentorshipSerializer < ActiveModel::Serializer
  attributes :id, :summary, :status, :profession, :company

  belongs_to :user, if: -> { instance_options[:include_user] }
  belongs_to :skill
end
