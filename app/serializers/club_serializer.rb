class ClubSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at
  
  has_many :club_members
  has_many :mentorships
  has_many :menteeships
end
