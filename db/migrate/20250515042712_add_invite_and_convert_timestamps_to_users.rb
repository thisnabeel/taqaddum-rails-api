class AddInviteAndConvertTimestampsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :invite_letter_sent_at, :datetime
    add_column :users, :converted_at, :datetime
  end
end
