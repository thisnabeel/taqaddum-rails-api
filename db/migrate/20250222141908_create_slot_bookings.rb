class CreateSlotBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :slot_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :slot, null: false, foreign_key: true
      t.string :status
      t.datetime :booking_date

      t.timestamps
    end

    # Add unique index to prevent duplicate bookings
    add_index :slot_bookings, [:user_id, :slot_id], unique: true
  end
end