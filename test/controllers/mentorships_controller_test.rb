require "test_helper"

class MentorshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mentorship = mentorships(:one)
  end

  test "should get index" do
    get mentorships_url, as: :json
    assert_response :success
  end

  test "should create mentorship" do
    assert_difference("Mentorship.count") do
      post mentorships_url, params: { mentorship: { skill_id: @mentorship.skill_id, summary: @mentorship.summary, user_id: @mentorship.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show mentorship" do
    get mentorship_url(@mentorship), as: :json
    assert_response :success
  end

  test "should update mentorship" do
    patch mentorship_url(@mentorship), params: { mentorship: { skill_id: @mentorship.skill_id, summary: @mentorship.summary, user_id: @mentorship.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy mentorship" do
    assert_difference("Mentorship.count", -1) do
      delete mentorship_url(@mentorship), as: :json
    end

    assert_response :no_content
  end
end
