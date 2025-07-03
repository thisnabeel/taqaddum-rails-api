class ClubMemberSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at
  
  belongs_to :club
  belongs_to :memberable
end
