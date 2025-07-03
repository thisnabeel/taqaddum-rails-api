class ClubMember < ApplicationRecord
  belongs_to :club
  belongs_to :memberable, polymorphic: true

  validates :club_id, uniqueness: { scope: [:memberable_type, :memberable_id], message: "Member is already part of this club" }
end
