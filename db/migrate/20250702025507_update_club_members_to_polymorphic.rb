class UpdateClubMembersToPolymorphic < ActiveRecord::Migration[7.1]
  def change
    remove_reference :club_members, :user, null: false, foreign_key: true
    
    add_reference :club_members, :memberable, polymorphic: true, null: false
  end
end
