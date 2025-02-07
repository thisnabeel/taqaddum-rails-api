require "test_helper"

class MeetingOfferingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meeting_offering = meeting_offerings(:one)
  end

  test "should get index" do
    get meeting_offerings_url, as: :json
    assert_response :success
  end

  test "should create meeting_offering" do
    assert_difference("MeetingOffering.count") do
      post meeting_offerings_url, params: { meeting_offering: { description: @meeting_offering.description, duration: @meeting_offering.duration, max_attendees: @meeting_offering.max_attendees, mentorship_id: @meeting_offering.mentorship_id, min_attendees: @meeting_offering.min_attendees, position: @meeting_offering.position, title: @meeting_offering.title } }, as: :json
    end

    assert_response :created
  end

  test "should show meeting_offering" do
    get meeting_offering_url(@meeting_offering), as: :json
    assert_response :success
  end

  test "should update meeting_offering" do
    patch meeting_offering_url(@meeting_offering), params: { meeting_offering: { description: @meeting_offering.description, duration: @meeting_offering.duration, max_attendees: @meeting_offering.max_attendees, mentorship_id: @meeting_offering.mentorship_id, min_attendees: @meeting_offering.min_attendees, position: @meeting_offering.position, title: @meeting_offering.title } }, as: :json
    assert_response :success
  end

  test "should destroy meeting_offering" do
    assert_difference("MeetingOffering.count", -1) do
      delete meeting_offering_url(@meeting_offering), as: :json
    end

    assert_response :no_content
  end
end
