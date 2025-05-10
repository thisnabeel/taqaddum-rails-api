class RenameColumnPreapproval < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :preapproval_pending, :preapproval_token
    change_column :users, :preapproval_token, :string
  end
end
