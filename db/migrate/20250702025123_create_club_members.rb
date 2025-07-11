class CreateClubMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :club_members do |t|
      t.belongs_to :club, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
