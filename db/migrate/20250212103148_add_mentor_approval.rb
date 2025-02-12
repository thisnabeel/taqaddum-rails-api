class AddMentorApproval < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :status, :string, default: "pending approval"
  end
end
