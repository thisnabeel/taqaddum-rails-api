class CreateMenteeships < ActiveRecord::Migration[7.1]
  def change
    create_table :menteeships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.text :summary

      t.timestamps
    end
  end
end
