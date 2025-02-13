class SlotsController < ApplicationController
  before_action :set_slot, only: %i[ show update destroy ]

  # GET /slots
  def index
    if params[:user_id]
      Slot.where(user_id: params[:user_id])
    else
      @slots = Slot.all
    end

    render json: @slots
  end

  # GET /slots/1
  def show
    render json: @slot
  end

  # POST /slots
  def create
    @slot = Slot.new(slot_params)

    if @slot.save
      render json: @slot, status: :created, location: @slot
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slots/1
  def update
    if @slot.update(slot_params)
      render json: @slot
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slots/1
  def destroy
    @slot.destroy!
  end

  def confirm
    @slot.confirm!
    render json: @slot
  end

  # PATCH /slots/:id/block
  def block
    @slot.block!
    render json: @slot
  end

  def configure
    slot_details = params[:slot_details]
    user_id = params[:user_id]
    meeting_offering_id = slot_details.dig("offering", "id")
    start_time = slot_details["start_time"]
    end_time = slot_details["end_time"]

    case params[:status]
    when "locked"
      slot = Slot.find_or_create_by(user_id: user_id, meeting_offering_id: meeting_offering_id, start_time: start_time, end_time: end_time)
      slot.update(status: "locked")
      message = "Slot locked successfully."

    when "denied"
      slot = Slot.find_or_create_by(user_id: user_id, meeting_offering_id: meeting_offering_id, start_time: start_time, end_time: end_time)
      slot.update(status: "denied")
      message = "Slot denied successfully."

    when "open"
      slot = Slot.find_by(user_id: user_id, meeting_offering_id: meeting_offering_id, start_time: start_time, end_time: end_time)
      if slot
        slot.destroy
        message = "Slot Open."
      else
        message = "No potential slot found."
      end
    else
      message = "Invalid status."
    end

    render json: { message: message, slot: slot || nil }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:user_id, :meeting_offering_id, :start_time, :end_time, :status)
    end
end
