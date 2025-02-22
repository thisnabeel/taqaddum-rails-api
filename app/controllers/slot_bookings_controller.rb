class SlotBookingsController < ApplicationController
  before_action :set_slot_booking, only: %i[ show update destroy ]

  # GET /slot_bookings
  def index
    @slot_bookings = SlotBooking.all

    render json: @slot_bookings
  end

  # GET /slot_bookings/1
  def show
    render json: @slot_booking
  end

  # POST /slot_bookings
  def create
    @slot_booking = SlotBooking.new(slot_booking_params)

    if @slot_booking.save
      render json: @slot_booking, status: :created, location: @slot_booking
    else
      render json: @slot_booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slot_bookings/1
  def update
    if @slot_booking.update(slot_booking_params)
      render json: @slot_booking
    else
      render json: @slot_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slot_bookings/1
  def destroy
    @slot_booking.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot_booking
      @slot_booking = SlotBooking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_booking_params
      params.require(:slot_booking).permit(:user_id, :slot_id, :status, :booking_date)
    end
end
