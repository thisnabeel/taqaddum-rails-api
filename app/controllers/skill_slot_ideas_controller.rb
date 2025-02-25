class SkillSlotIdeasController < ApplicationController
  before_action :set_skill_slot_idea, only: %i[ show update destroy ]

  # GET /skill_slot_ideas
  def index
    @skill_slot_ideas = SkillSlotIdea.all

    render json: @skill_slot_ideas
  end

  # GET /skill_slot_ideas/1
  def show
    render json: @skill_slot_idea
  end

  # POST /skill_slot_ideas
  def create
    @skill_slot_idea = SkillSlotIdea.new(skill_slot_idea_params)

    if @skill_slot_idea.save
      render json: @skill_slot_idea, status: :created, location: @skill_slot_idea
    else
      render json: @skill_slot_idea.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skill_slot_ideas/1
  def update
    if @skill_slot_idea.update(skill_slot_idea_params)
      render json: @skill_slot_idea
    else
      render json: @skill_slot_idea.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skill_slot_ideas/1
  def destroy
    @skill_slot_idea.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_slot_idea
      @skill_slot_idea = SkillSlotIdea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def skill_slot_idea_params
      params.require(:skill_slot_idea).permit(:title, :description, :skill_id)
    end
end
