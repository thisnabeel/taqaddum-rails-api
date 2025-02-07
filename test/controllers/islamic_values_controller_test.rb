require "test_helper"

class IslamicValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @islamic_value = islamic_values(:one)
  end

  test "should get index" do
    get islamic_values_url, as: :json
    assert_response :success
  end

  test "should create islamic_value" do
    assert_difference("IslamicValue.count") do
      post islamic_values_url, params: { islamic_value: { description: @islamic_value.description, title: @islamic_value.title } }, as: :json
    end

    assert_response :created
  end

  test "should show islamic_value" do
    get islamic_value_url(@islamic_value), as: :json
    assert_response :success
  end

  test "should update islamic_value" do
    patch islamic_value_url(@islamic_value), params: { islamic_value: { description: @islamic_value.description, title: @islamic_value.title } }, as: :json
    assert_response :success
  end

  test "should destroy islamic_value" do
    assert_difference("IslamicValue.count", -1) do
      delete islamic_value_url(@islamic_value), as: :json
    end

    assert_response :no_content
  end
end
