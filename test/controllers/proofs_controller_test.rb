require "test_helper"

class ProofsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proof = proofs(:one)
  end

  test "should get index" do
    get proofs_url, as: :json
    assert_response :success
  end

  test "should create proof" do
    assert_difference("Proof.count") do
      post proofs_url, params: { proof: { menteeship_id: @proof.menteeship_id, mentorship_id: @proof.mentorship_id, position: @proof.position } }, as: :json
    end

    assert_response :created
  end

  test "should show proof" do
    get proof_url(@proof), as: :json
    assert_response :success
  end

  test "should update proof" do
    patch proof_url(@proof), params: { proof: { menteeship_id: @proof.menteeship_id, mentorship_id: @proof.mentorship_id, position: @proof.position } }, as: :json
    assert_response :success
  end

  test "should destroy proof" do
    assert_difference("Proof.count", -1) do
      delete proof_url(@proof), as: :json
    end

    assert_response :no_content
  end
end
