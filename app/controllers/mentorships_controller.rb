class MentorshipsController < ApplicationController
  before_action :set_mentorship, only: %i[ show update destroy ]

  # GET /mentorships
  def index
    if params[:user_id]
      @mentorships = User.find(params[:user_id]).mentorships
    else
      @mentorships = Mentorship.all
    end
    render json: @mentorships, each_serializer: MentorshipSerializer

  end

  def top
    mentorships = Mentorship.where(status: "approved")
                            .joins(:user)
                            .distinct
                            .group_by(&:user_id) # Group by user

    # Select one random mentorship per unique user, then pick 3 users
    unique_mentorships = mentorships.values.map(&:sample).shuffle.take(3)

    render json: unique_mentorships, each_serializer: MentorshipSerializer, include_user: true
  end


  # GET /mentorships/1
  def show
    render json: @mentorship
  end

  # POST /mentorships
  def create
    @mentorship = Mentorship.new(mentorship_params)

    if @mentorship.save
      render json: @mentorship, status: :created, location: @mentorship
    else
      render json: @mentorship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mentorships/1
  def update
    if @mentorship.update(mentorship_params)
      render json: @mentorship
    else
      render json: @mentorship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mentorships/1
  def destroy
    @mentorship.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentorship
      @mentorship = Mentorship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mentorship_params
      params.require(:mentorship).permit(:user_id, :skill_id, :summary, :company, :profession, :status)
    end
end
