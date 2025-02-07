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
    @mentors = User.joins(mentorships: :meeting_offerings)
            .distinct
            .limit(3)

    render json: @mentors, each_serializer: UserSerializer
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
      params.require(:mentorship).permit(:user_id, :skill_id, :summary)
    end
end
