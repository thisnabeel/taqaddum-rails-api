class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def upload_avatar
    render json: User.find(params[:user_id]).upload_avatar(params)
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      create_mentorships_and_menteeships(resource) # Create mentorships & menteeships
      render json: UserSerializer.new(resource).serializable_hash, status: :created
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_mentorships_and_menteeships(user)
    mentor_skills = params[:user][:mentor_skills] || []
    mentee_skills = params[:user][:mentee_skills] || []

    mentor_skills.each do |skill|
      user.mentorships.create(skill: Skill.find(skill[:id]))
    end

    mentee_skills.each do |skill|
      user.menteeships.create(skill: Skill.find(skill[:id]))
    end
  end

end
