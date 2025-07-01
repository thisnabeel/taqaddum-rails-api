class QuestionAnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :mentorship
  
  belongs_to :user
  belongs_to :question

  def mentorship
    if object.question.questionable_type == "Skill"
      object.user.mentorships.find_by(skill_id: object.question.questionable_id)
    end
  end
end
