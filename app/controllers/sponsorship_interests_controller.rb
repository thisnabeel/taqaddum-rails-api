class SponsorshipInterestsController < ApplicationController
  before_action :set_sponsorship_interest, only: %i[ show update destroy ]

  # GET /sponsorship_interests
  def index
    @sponsorship_interests = SponsorshipInterest.all

    render json: @sponsorship_interests
  end

  # GET /sponsorship_interests/1
  def show
    render json: @sponsorship_interest
  end

  # POST /sponsorship_interests
  def create
    @sponsorship_interest = SponsorshipInterest.new(sponsorship_interest_params)

    if @sponsorship_interest.save
      render json: @sponsorship_interest, status: :created, location: @sponsorship_interest
    else
      render json: @sponsorship_interest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sponsorship_interests/1
  def update
    if @sponsorship_interest.update(sponsorship_interest_params)
      render json: @sponsorship_interest
    else
      render json: @sponsorship_interest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sponsorship_interests/1
  def destroy
    @sponsorship_interest.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsorship_interest
      @sponsorship_interest = SponsorshipInterest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sponsorship_interest_params
      params.require(:sponsorship_interest).permit(:contact_name, :contact_email, :contact_phone, :org_name, :org_website, :org_details, :status)
    end
end
