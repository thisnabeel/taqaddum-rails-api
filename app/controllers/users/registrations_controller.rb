class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # Override create method
  def create

    Rails.logger.info "Received params: #{params.inspect}" # Debug params
    # Extract mentor and mentee skills before filtering parameters
    mentor_skills = params[:user].delete(:mentor_skills) || []
    mentee_skills = params[:user].delete(:mentee_skills) || []

    # Call Devise's default user creation method
    super do |user|
      if user.persisted?
        create_mentorships_and_menteeships(user, mentor_skills, mentee_skills)
        render json: UserSerializer.new(user).serializable_hash, status: :created and return
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity and return
      end
    end
  end

  def create_with_preapproval
    Rails.logger.info "Received params for preapproval: #{params.inspect}" # Debug params

    # Normalize camelCase keys to snake_case
    params[:user][:mentor_skills] = params[:user].delete(:mentorSkills) || []
    params[:user][:mentee_skills] = params[:user].delete(:menteeSkills) || []

    mentor_skills = params[:user].delete(:mentor_skills)
    mentee_skills = params[:user].delete(:mentee_skills)
    skills = params[:user].delete(:skills) || [] # Extract skills separately
    # Add linkedin_url and other attributes to permitted parameters
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :profession, :company, :type, :linkedin_url)

    # Ensure the preapproval_token is unique to the user
    preapproval_token = ""
    loop do
      preapproval_token = SecureRandom.uuid[0..5] # Generate a 6-character UUID
      break unless User.exists?(preapproval_token: preapproval_token)
    end

    user = User.new(user_params.merge(password: "invited101!", preapproval_token: preapproval_token))

    if user.save
      # Create associated skills for the user
      skills.each do |skill|
        user.skills.create(skill.permit(:id, :title, :description)) if skill[:id].present?
      end

      create_mentorships_and_menteeships(user, mentor_skills, mentee_skills)
      render json: UserSerializer.new(user).serializable_hash, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update

    puts "HELLOO"
    user = User.find(params[:user][:id]) # Ensure you're updating the current user

    mentor_skills = params[:user].delete(:mentor_skills) || []
    mentee_skills = params[:user].delete(:mentee_skills) || []

    if user.update(account_update_params)
      create_mentorships_and_menteeships(user, mentor_skills, mentee_skills)
      render json: UserSerializer.new(user).serializable_hash, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_avatar
    puts params
    render json: User.find(params[:user_id]).upload_avatar(params)
  end

  private

  def create_mentorships_and_menteeships(user, mentor_skills, mentee_skills)
    mentor_skills.each do |skill|
      user.mentorships.create(skill: Skill.find(skill[:id]), company: skill[:company], profession: skill[:profession]) if skill[:id].present?
    end

    mentee_skills.each do |skill|
      user.menteeships.create(skill: Skill.find(skill[:id]), company: skill[:company], profession: skill[:profession]) if skill[:id].present?
    end
  end

  # Permit only user attributes that are directly part of the model
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profession, :company, :type)
  end
end
