class CreateIslamicValues < ActiveRecord::Migration[7.1]
  def change
    create_table :islamic_values do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
