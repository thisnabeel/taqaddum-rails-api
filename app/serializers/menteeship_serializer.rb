# app/serializers/menteeship_serializer.rb
class MenteeshipSerializer < ActiveModel::Serializer
  attributes :id, :summary

  belongs_to :user
  belongs_to :skill
end
