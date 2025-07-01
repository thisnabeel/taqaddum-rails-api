require "test_helper"

class QuestionAnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get question_answers_index_url
    assert_response :success
  end

  test "should get show" do
    get question_answers_show_url
    assert_response :success
  end

  test "should get create" do
    get question_answers_create_url
    assert_response :success
  end

  test "should get update" do
    get question_answers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get question_answers_destroy_url
    assert_response :success
  end
end
