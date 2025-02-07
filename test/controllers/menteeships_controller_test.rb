require "test_helper"

class MenteeshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menteeship = menteeships(:one)
  end

  test "should get index" do
    get menteeships_url, as: :json
    assert_response :success
  end

  test "should create menteeship" do
    assert_difference("Menteeship.count") do
      post menteeships_url, params: { menteeship: { skill_id: @menteeship.skill_id, summary: @menteeship.summary, user_id: @menteeship.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show menteeship" do
    get menteeship_url(@menteeship), as: :json
    assert_response :success
  end

  test "should update menteeship" do
    patch menteeship_url(@menteeship), params: { menteeship: { skill_id: @menteeship.skill_id, summary: @menteeship.summary, user_id: @menteeship.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy menteeship" do
    assert_difference("Menteeship.count", -1) do
      delete menteeship_url(@menteeship), as: :json
    end

    assert_response :no_content
  end
end
