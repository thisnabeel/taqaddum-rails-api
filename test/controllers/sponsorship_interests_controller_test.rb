require "test_helper"

class SponsorshipInterestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sponsorship_interest = sponsorship_interests(:one)
  end

  test "should get index" do
    get sponsorship_interests_url, as: :json
    assert_response :success
  end

  test "should create sponsorship_interest" do
    assert_difference("SponsorshipInterest.count") do
      post sponsorship_interests_url, params: { sponsorship_interest: { contact_email: @sponsorship_interest.contact_email, contact_name: @sponsorship_interest.contact_name, contact_phone: @sponsorship_interest.contact_phone, org_details: @sponsorship_interest.org_details, org_name: @sponsorship_interest.org_name, org_website: @sponsorship_interest.org_website, status: @sponsorship_interest.status } }, as: :json
    end

    assert_response :created
  end

  test "should show sponsorship_interest" do
    get sponsorship_interest_url(@sponsorship_interest), as: :json
    assert_response :success
  end

  test "should update sponsorship_interest" do
    patch sponsorship_interest_url(@sponsorship_interest), params: { sponsorship_interest: { contact_email: @sponsorship_interest.contact_email, contact_name: @sponsorship_interest.contact_name, contact_phone: @sponsorship_interest.contact_phone, org_details: @sponsorship_interest.org_details, org_name: @sponsorship_interest.org_name, org_website: @sponsorship_interest.org_website, status: @sponsorship_interest.status } }, as: :json
    assert_response :success
  end

  test "should destroy sponsorship_interest" do
    assert_difference("SponsorshipInterest.count", -1) do
      delete sponsorship_interest_url(@sponsorship_interest), as: :json
    end

    assert_response :no_content
  end
end
