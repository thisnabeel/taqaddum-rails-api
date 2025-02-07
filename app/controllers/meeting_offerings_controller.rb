class MeetingOfferingsController < ApplicationController
  before_action :set_meeting_offering, only: %i[show update destroy]

  # GET /meeting_offerings
  def index
    if params[:user_id]
      @meeting_offerings = User.find(params[:user_id]).meeting_offerings
    else
      @meeting_offerings = MeetingOffering.all
    end
    render json: @meeting_offerings
  end

  # GET /meeting_offerings/1
  def show
    render json: @meeting_offering
  end

  # POST /meeting_offerings
  def create
    @meeting_offering = MeetingOffering.new(meeting_offering_params)

    if @meeting_offering.save
      render json: @meeting_offering, status: :created
    else
      render json: { errors: @meeting_offering.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meeting_offerings/1
  def update
    if @meeting_offering.update(meeting_offering_params)
      render json: @meeting_offering, status: :ok
    else
      render json: { errors: @meeting_offering.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /meeting_offerings/1
  def destroy
    @meeting_offering.destroy
    head :no_content
  end

  private

  def set_meeting_offering
    @meeting_offering = MeetingOffering.find(params[:id])
  end

  def meeting_offering_params
    params.require(:meeting_offering).permit(:title, :mentorship_id, :description, :duration, :position, :max_attendees, :min_attendees)
  end
end
