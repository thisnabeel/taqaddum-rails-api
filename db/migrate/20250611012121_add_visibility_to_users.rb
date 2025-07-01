class AddVisibilityToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :visibility, :string, default: "connections"
    add_check_constraint :users, "visibility IN ('global', 'connections', 'hidden')", name: "check_visibility_enum"
  end
end
