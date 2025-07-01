require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @skill = skills(:one)
    @question = questions(:one)
  end

  test "should get index" do
    get questions_url
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post questions_url, params: { 
        question: { 
          body: "Test question", 
          user_id: @user.id, 
          questionable_type: "Skill", 
          questionable_id: @skill.id 
        } 
      }
    end

    assert_response :created
  end

  test "should show question" do
    get question_url(@question)
    assert_response :success
  end

  test "should update question" do
    patch question_url(@question), params: { 
      question: { body: "Updated question" } 
    }
    assert_response :success
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question)
    end

    assert_response :no_content
  end

  test "should get questions from user" do
    get "/questions/from/#{@user.id}"
    assert_response :success
  end

  test "should get questions from questionable" do
    get "/questions/from/Skill/#{@skill.id}"
    assert_response :success
  end
end 