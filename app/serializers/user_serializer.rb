# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :birthdate, :profession, :email, :mentorships, :avatar_source_url, :avatar_cropped_url, :company, :type, :menteeships, :preapproval_token, :roles, :converted_at, :linkedin_url

  def mentorships
    return object.mentorships.order("created_at ASC").map {|m| MentorshipSerializer.new(m, include_user: false)}
  end

  def menteeships
    return object.menteeships.order("created_at ASC").map {|m| MentorshipSerializer.new(m, include_user: false)}
  end

end
