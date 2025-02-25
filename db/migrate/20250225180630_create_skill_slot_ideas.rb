class CreateSkillSlotIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :skill_slot_ideas do |t|
      t.string :title
      t.text :description
      t.belongs_to :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
