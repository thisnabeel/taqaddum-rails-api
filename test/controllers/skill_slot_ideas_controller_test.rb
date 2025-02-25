require "test_helper"

class SkillSlotIdeasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @skill_slot_idea = skill_slot_ideas(:one)
  end

  test "should get index" do
    get skill_slot_ideas_url, as: :json
    assert_response :success
  end

  test "should create skill_slot_idea" do
    assert_difference("SkillSlotIdea.count") do
      post skill_slot_ideas_url, params: { skill_slot_idea: { description: @skill_slot_idea.description, skill_id: @skill_slot_idea.skill_id, title: @skill_slot_idea.title } }, as: :json
    end

    assert_response :created
  end

  test "should show skill_slot_idea" do
    get skill_slot_idea_url(@skill_slot_idea), as: :json
    assert_response :success
  end

  test "should update skill_slot_idea" do
    patch skill_slot_idea_url(@skill_slot_idea), params: { skill_slot_idea: { description: @skill_slot_idea.description, skill_id: @skill_slot_idea.skill_id, title: @skill_slot_idea.title } }, as: :json
    assert_response :success
  end

  test "should destroy skill_slot_idea" do
    assert_difference("SkillSlotIdea.count", -1) do
      delete skill_slot_idea_url(@skill_slot_idea), as: :json
    end

    assert_response :no_content
  end
end
