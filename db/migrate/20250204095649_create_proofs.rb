class CreateProofs < ActiveRecord::Migration[7.1]
  def change
    create_table :proofs do |t|
      t.references :mentorship, null: false, foreign_key: true
      t.references :menteeship, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
