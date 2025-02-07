class SkillSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  # has_many :mentorships
  # has_many :menteeships
end