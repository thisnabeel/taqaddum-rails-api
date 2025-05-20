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

  def mentees
    menteeships = Menteeship.includes(:user).group_by(&:status).transform_values do |group|
      group.map { |menteeship| MenteeshipSerializer.new(menteeship, include_user: true) }
    end

    render json: menteeships
  end

  def leads
    leads = User.where.not(preapproval_token: nil)
    render json: leads
  end

  def send_invitation
    inviter = User.find(params[:inviter_id])
    user = User.find(params[:invitee_id])

    # Assuming Resend API client is configured
    require "resend"

    Resend.api_key = ENV["RESEND_API_KEY"]

    payload = {
      "from": "Taqaddum Team <donotreply@office.taqaddum.org>",
      "to": [user.email],
      "html": params[:body],
      "subject": "PREAPPROVED - #{inviter.first_name} is inviting you to Taqaddum"
    }
    r = Resend::Emails.send(payload)

    render json: { message: "Invitation sent successfully to #{user.email}" }, status: :ok
  rescue StandardError => e
    puts e.message
    render json: { error: e.message }, status: :unprocessable_entity
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
      :status,
      :type
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
