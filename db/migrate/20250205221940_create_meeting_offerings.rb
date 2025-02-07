class CreateMeetingOfferings < ActiveRecord::Migration[7.1]
  def change
    create_table :meeting_offerings do |t|
      t.string :title
      t.references :mentorship, null: false, foreign_key: true
      t.text :description
      t.integer :duration
      t.integer :position
      t.integer :max_attendees
      t.integer :min_attendees

      t.timestamps
    end
  end
end
