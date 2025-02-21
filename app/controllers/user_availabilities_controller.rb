class UserAvailabilitiesController < ApplicationController
  # Get the user's availability
  def index
    availabilities = User.find_by(id: params[:user_id])&.user_availabilities
    render json: availabilities
  end

  def open_slots
    # availabilities = User.find_by(id: params[:user_id])&.available_meetups_for_next_week
    user = User.find_by(id: params[:user_id])
    availabilities = user.slots.order("start_time ASC")
    render json: {
      user: user,
      slots: availabilities.map {|a| SlotSerializer.new(a)}
    }
  end

  # Save or update availability
  def create
    user = User.find_by(id: params[:user_id])
    return render json: { error: "User not found" }, status: :not_found unless user

    user.user_availabilities.destroy_all

    availability_params[:availability].each do |slot|
      existing_slot = user.user_availabilities.find_by(
        day: slot[:day],
        start_time: slot[:start_time],
        end_time: slot[:end_time]
      )

      unless existing_slot
        user.user_availabilities.create!(
          day: slot[:day],
          start_time: slot[:start_time],
          end_time: slot[:end_time],
          timezone: availability_params[:timezone]
        )
      end
    end

    render json: user.user_availabilities, status: :ok
  end

  private

  def availability_params
    params.require(:user).permit(:timezone, availability: [:day, :start_time, :end_time])
  end
end
