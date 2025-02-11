class UsersController < ApplicationController
  before_action :set_user, only: %i[update]

  def update
    mentor_skills = params[:user].delete(:mentor_skills) || []
    mentee_skills = params[:user].delete(:mentee_skills) || []

    if @user.update(user_params)
      update_mentorships_and_menteeships(@user, mentor_skills, mentee_skills)
      render json: @user, serializer: UserSerializer, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
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
      :company
    )
  end

  def update_mentorships_and_menteeships(user, mentor_skills, mentee_skills)
    # Extract skill IDs from the input arrays
    mentor_skill_ids = mentor_skills.map { |skill| skill[:id] }.compact
    mentee_skill_ids = mentee_skills.map { |skill| skill[:id] }.compact

    # Delete mentorships that are not in the new list
    user.mentorships.where.not(skill_id: mentor_skill_ids).destroy_all
    # Add new mentorships
    mentor_skill_ids.each do |skill_id|
      user.mentorships.find_or_create_by(skill_id: skill_id)
    end

    # Delete menteeships that are not in the new list
    user.menteeships.where.not(skill_id: mentee_skill_ids).destroy_all
    # Add new menteeships
    mentee_skill_ids.each do |skill_id|
      user.menteeships.find_or_create_by(skill_id: skill_id)
    end
  end


end
