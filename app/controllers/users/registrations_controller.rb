class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # Override create method
  def create
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profession, :company)
  end
end
