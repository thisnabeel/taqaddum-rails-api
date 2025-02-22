require "test_helper"

class LettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @letter = letters(:one)
  end

  test "should get index" do
    get letters_url, as: :json
    assert_response :success
  end

  test "should create letter" do
    assert_difference("Letter.count") do
      post letters_url, params: { letter: { body: @letter.body, letter_type: @letter.letter_type, mentee_id: @letter.mentee_id, mentor_id: @letter.mentor_id, read: @letter.read } }, as: :json
    end

    assert_response :created
  end

  test "should show letter" do
    get letter_url(@letter), as: :json
    assert_response :success
  end

  test "should update letter" do
    patch letter_url(@letter), params: { letter: { body: @letter.body, letter_type: @letter.letter_type, mentee_id: @letter.mentee_id, mentor_id: @letter.mentor_id, read: @letter.read } }, as: :json
    assert_response :success
  end

  test "should destroy letter" do
    assert_difference("Letter.count", -1) do
      delete letter_url(@letter), as: :json
    end

    assert_response :no_content
  end
end
