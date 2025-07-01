class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :menteeship

  belongs_to :user
  belongs_to :questionable

  def menteeship
    if object.questionable_type == "Skill"
      object.user.menteeships.find_by(skill_id: object.questionable_id)
    end
  end
end 