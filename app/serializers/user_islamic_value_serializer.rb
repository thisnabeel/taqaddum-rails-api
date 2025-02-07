class UserIslamicValueSerializer < ActiveModel::Serializer
  attributes :id, :summary

  belongs_to :user
  belongs_to :islamic_value
end
