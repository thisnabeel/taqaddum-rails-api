class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :questionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
