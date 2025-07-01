require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @skill = skills(:one)
  end

  test "should be valid with valid attributes" do
    question = Question.new(
      body: "What is the best way to learn Rails?",
      user: @user,
      questionable: @skill
    )
    assert question.valid?
  end

  test "should require body" do
    question = Question.new(
      user: @user,
      questionable: @skill
    )
    assert_not question.valid?
    assert_includes question.errors[:body], "can't be blank"
  end

  test "should belong to user" do
    question = Question.new(
      body: "Test question",
      questionable: @skill
    )
    assert_not question.valid?
    assert_includes question.errors[:user], "must exist"
  end

  test "should belong to questionable" do
    question = Question.new(
      body: "Test question",
      user: @user
    )
    assert_not question.valid?
    assert_includes question.errors[:questionable], "must exist"
  end

  test "should be able to associate with different questionable types" do
    question1 = Question.create!(
      body: "Question about skill",
      user: @user,
      questionable: @skill
    )
    
    mentorship = mentorships(:one)
    question2 = Question.create!(
      body: "Question about mentorship",
      user: @user,
      questionable: mentorship
    )

    assert_equal @skill, question1.questionable
    assert_equal mentorship, question2.questionable
  end
end 