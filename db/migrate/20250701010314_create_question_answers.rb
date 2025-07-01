class CreateQuestionAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :question_answers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
