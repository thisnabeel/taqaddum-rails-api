require "test_helper"

class UserIslamicValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_islamic_value = user_islamic_values(:one)
  end

  test "should get index" do
    get user_islamic_values_url, as: :json
    assert_response :success
  end

  test "should create user_islamic_value" do
    assert_difference("UserIslamicValue.count") do
      post user_islamic_values_url, params: { user_islamic_value: { islamic_value_id: @user_islamic_value.islamic_value_id, summary: @user_islamic_value.summary, user_id: @user_islamic_value.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show user_islamic_value" do
    get user_islamic_value_url(@user_islamic_value), as: :json
    assert_response :success
  end

  test "should update user_islamic_value" do
    patch user_islamic_value_url(@user_islamic_value), params: { user_islamic_value: { islamic_value_id: @user_islamic_value.islamic_value_id, summary: @user_islamic_value.summary, user_id: @user_islamic_value.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy user_islamic_value" do
    assert_difference("UserIslamicValue.count", -1) do
      delete user_islamic_value_url(@user_islamic_value), as: :json
    end

    assert_response :no_content
  end
end
