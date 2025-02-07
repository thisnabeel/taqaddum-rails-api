class UserAvatars < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :avatar_cropped_url, :string
    add_column :users, :avatar_source_url, :string
  end
end
