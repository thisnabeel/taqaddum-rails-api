class CreateUserAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :user_availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :day
      t.time :start_time
      t.time :end_time
      t.string :timezone

      t.timestamps
    end
  end
end
