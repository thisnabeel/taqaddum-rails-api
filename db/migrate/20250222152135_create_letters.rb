class CreateLetters < ActiveRecord::Migration[7.1]
  def change
    create_table :letters do |t|
      t.text :body
      t.string :letter_type
      t.references :mentor, null: false, foreign_key: { to_table: :users }
      t.references :mentee, null: false, foreign_key: { to_table: :users }
      t.boolean :read

      t.timestamps
    end
  end
end
