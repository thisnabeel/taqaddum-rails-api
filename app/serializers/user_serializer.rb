# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :birthdate, :profession, :email, :mentorships, :avatar_source_url, :avatar_cropped_url

  def mentorships
    return object.mentorships.map {|m| MentorshipSerializer.new(m, include_user: false)}
  end
end
