class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all
    render json: @questions
  end

  # GET /questions/:id
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    
    if @question.save
      render json: @question, status: :created, serializer: QuestionSerializer
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/:id
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /questions/:id
  def destroy
    @question.destroy
    head :no_content
  end

  # GET /questions/from/:user_id
  def from_user
    @questions = Question.where(user_id: params[:user_id])

    render json: @questions, each_serializer: QuestionSerializer
  end

  # GET /questions/for/:user_id
  def for_user
    @questions = Mentor.find(params[:user_id]).questions_pool
    render json: @questions, each_serializer: QuestionSerializer
  end

  # GET /questions/from/:questionable_type/:questionable_id
  def from_questionable
    @questions = Question.where(
      questionable_type: params[:questionable_type],
      questionable_id: params[:questionable_id]
    )
    # binding.pry
    render json: @questions
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :user_id, :questionable_type, :questionable_id)
  end
end 