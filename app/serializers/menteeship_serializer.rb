# app/serializers/menteeship_serializer.rb
class MenteeshipSerializer < ActiveModel::Serializer
  attributes :id, :summary, :status, :profession, :company

  belongs_to :user, if: -> { instance_options[:include_user] }
  belongs_to :skill
end
