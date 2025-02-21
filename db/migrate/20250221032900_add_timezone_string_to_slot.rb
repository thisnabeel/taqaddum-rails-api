class AddTimezoneStringToSlot < ActiveRecord::Migration[7.1]
  def change
    add_column :slots, :timezone, :string
  end
end
