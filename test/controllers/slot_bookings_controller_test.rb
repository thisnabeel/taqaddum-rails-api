require "test_helper"

class SlotBookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot_booking = slot_bookings(:one)
  end

  test "should get index" do
    get slot_bookings_url, as: :json
    assert_response :success
  end

  test "should create slot_booking" do
    assert_difference("SlotBooking.count") do
      post slot_bookings_url, params: { slot_booking: { booking_date: @slot_booking.booking_date, slot_id: @slot_booking.slot_id, status: @slot_booking.status, user_id: @slot_booking.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show slot_booking" do
    get slot_booking_url(@slot_booking), as: :json
    assert_response :success
  end

  test "should update slot_booking" do
    patch slot_booking_url(@slot_booking), params: { slot_booking: { booking_date: @slot_booking.booking_date, slot_id: @slot_booking.slot_id, status: @slot_booking.status, user_id: @slot_booking.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy slot_booking" do
    assert_difference("SlotBooking.count", -1) do
      delete slot_booking_url(@slot_booking), as: :json
    end

    assert_response :no_content
  end
end
