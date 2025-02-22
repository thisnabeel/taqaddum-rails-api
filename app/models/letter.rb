class Letter < ApplicationRecord
  belongs_to :mentor, class_name: 'User'
  belongs_to :mentee, class_name: 'User'
  
  validates :body, presence: true
  validates :letter_type, presence: true
  validates :read, inclusion: { in: [true, false] }
end