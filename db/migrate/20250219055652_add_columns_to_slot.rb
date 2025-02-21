class AddColumnsToSlot < ActiveRecord::Migration[7.1]
  def change
    add_column :slots, :description, :text
    add_column :slots, :duration, :integer, default: 30
    add_column :slots, :title, :string
    add_column :slots, :max_attendees, :integer
    add_column :slots, :min_attendees, :integer
  end
end
