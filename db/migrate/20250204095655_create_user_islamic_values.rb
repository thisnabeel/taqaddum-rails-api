class CreateUserIslamicValues < ActiveRecord::Migration[7.1]
  def change
    create_table :user_islamic_values do |t|
      t.references :islamic_value, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :summary

      t.timestamps
    end
  end
end
