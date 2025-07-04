class SkillsController < ApplicationController
  before_action :set_skill, only: %i[ show update destroy mentees mentors ]

  # GET /skills
  def index
    @skills = Skill.all
    if params[:search]
      @skills = @skills.where('title ILIKE ?', "%#{params[:search]}%")
    end
    render json: @skills.shuffle
  end

  # GET /skills/:id/mentees
  def mentees
    @mentees = @skill.mentees.includes(:menteeships)
    render json: @mentees.map { |mentee| 
      mentee.as_json.merge(
        menteeship: mentee.menteeships.find_by(skill: @skill)
      )
    }
  end

  # GET /skills/:id/mentors
  def mentors
    @mentors = @skill.mentors.includes(:mentorships)
    render json: @mentors.map { |mentor| 
      mentor.as_json.merge(
        mentorship: mentor.mentorships.find_by(skill: @skill)
      )
    }
  end

  def offerings_ai
    @skill_slot_ideas = SkillSlotIdea.where(skill_id: params[:id])
    if !@skill_slot_ideas.present?
      prompt = "
        give me 5 online workshop meeting ideas for `#{params[:title]}` career building. Geared towards mentees in college. for an hour long meeting.
        give in one single flat array of objects like [{title:, description: (under 200 characters starting with 'We Will...')},...]
      "
      response = Wizard.request(prompt)
  
      # If the response is wrapped inside a key like "workshops", extract it
      ideas = response.is_a?(Hash) && response["workshops"] ? response["workshops"] : response
      @skill_slot_ideas = ideas.map do |idea|
        begin
          SkillSlotIdea.create!(title: idea["title"], description: idea["description"], skill_id: params[:id])
        rescue => e
          puts e
        end
      end
    end

    render json: @skill_slot_ideas
  end


  # GET /skills/1
  def show
    render json: @skill
  end

  # POST /skills
  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      render json: @skill, status: :created, location: @skill
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skills/1
  def update
    if @skill.update(skill_params)
      render json: @skill
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = if params[:id].match?(/\A\d+\z/)
        Skill.find_by(id: params[:id])
      else
        Skill.find_by(title: params[:id].titleize)
      end

      render json: { error: "Skill not found" }, status: :not_found unless @skill
    end

    # Only allow a list of trusted parameters through.
    def skill_params
      params.require(:skill).permit(:title, :description)
    end
end
