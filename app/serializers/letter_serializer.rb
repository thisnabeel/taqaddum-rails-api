class LetterSerializer < ActiveModel::Serializer
  attributes :id, :body, :letter_type, :read
  has_one :mentor
  has_one :mentee
end
