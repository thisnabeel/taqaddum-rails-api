class RemoveUniqueIndexFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, :email if index_exists?(:users, :email) # Remove old unique index
    add_index :users, [:email, :type], unique: true # Add new unique constraint
  end
end