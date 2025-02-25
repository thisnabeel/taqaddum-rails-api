class SkillSlotIdea < ApplicationRecord
  belongs_to :skill


  validates :title, presence: true
  validates :description, presence: true
end
