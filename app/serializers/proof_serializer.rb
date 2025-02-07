class ProofSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :mentorship
  belongs_to :menteeship
end
