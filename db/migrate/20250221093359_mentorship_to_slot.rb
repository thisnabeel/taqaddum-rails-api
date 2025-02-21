class MentorshipToSlot < ActiveRecord::Migration[7.1]
  def change
    add_reference :slots, :mentorship, foreign_key: true
  end
end
