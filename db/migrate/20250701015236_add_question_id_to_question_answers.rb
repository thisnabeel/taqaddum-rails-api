class AddQuestionIdToQuestionAnswers < ActiveRecord::Migration[7.1]
  def change
    add_reference :question_answers, :question, null: false, foreign_key: true
  end
end
