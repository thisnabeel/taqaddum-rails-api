class Question < ApplicationRecord
  belongs_to :user
  belongs_to :questionable, polymorphic: true
  has_many :question_answers, dependent: :destroy

  validates :body, presence: true
end 