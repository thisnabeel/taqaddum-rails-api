class UsersController < ApplicationController
  before_action :set_user, only: %i[update]

  def update
    params[:user].delete(:id)
    mentor_skills_to_add = params[:user].delete(:mentor_skills_to_add) || []
    mentee_skills_to_add = params[:user].delete(:mentee_skills_to_add) || []

    update_mentorships = params[:user].delete(:update_mentorships) || []
    update_menteeships = params[:user].delete(:update_menteeships) || []

    if @user.update(user_params)
      apply_mentorships_and_menteeships(@user, mentor_skills_to_add, mentee_skills_to_add)
      update_mentorships_and_menteeships(@user, update_mentorships, update_menteeships)
      render json: @user, serializer: UserSerializer, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def mentors
    mentorships = Mentorship.includes(:user).group_by(&:status).transform_values do |group|
      group.map { |mentorship| MentorshipSerializer.new(mentorship, include_user: true) }
    end

    render json: mentorships
  end




  private

  def set_user
    @user = User.find(params[:user][:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :birthdate,
      :profession,
      :avatar_source_url,
      :avatar_cropped_url,
      :company,
      :status
    )
  end

  def apply_mentorships_and_menteeships(user, mentorships, menteeships)
    mentorships.each do |m|
      puts m
      mentorship = user.mentorships.find_or_create_by!(skill_id: m[:skill][:id])
      
      # Ensure m[:profession] and m[:company] exist before updating
      mentorship.update!(profession: m[:profession], company: m[:company]) 
    end

    menteeships.each do |m|
      puts m
      menteeship = user.mentorships.find_or_create_by!(skill_id: m[:skill][:id])
      
      # Ensure m[:profession] and m[:company] exist before updating
      menteeship.update!(profession: m[:profession], company: m[:company]) 
    end
  end

  def update_mentorships_and_menteeships(user, mentorships, menteeships)
    mentorships.each do |m|
      puts m
      mentorship = Mentorship.find(m[:id]).update!(profession: m[:profession], company: m[:company]) 
    end

    menteeships.each do |m|
      puts m
      menteeship = Menteeship.find(m[:id]).update!(profession: m[:profession], company: m[:company]) 
    end
  end
end
