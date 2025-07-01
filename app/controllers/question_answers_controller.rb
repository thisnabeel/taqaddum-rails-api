class QuestionAnswersController < ApplicationController
  before_action :set_question_answer, only: [:show, :update, :destroy]

  def index
    @question_answers = QuestionAnswer.all
    render json: @question_answers, each_serializer: QuestionAnswerSerializer
  end

  def show
    render json: @question_answer, serializer: QuestionAnswerSerializer
  end

  def create
    @question_answer = QuestionAnswer.new(question_answer_params)

    if @question_answer.save
      render json: @question_answer, serializer: QuestionAnswerSerializer, status: :created
    else
      render json: @question_answer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @question_answer.update(question_answer_params)
      render json: @question_answer, serializer: QuestionAnswerSerializer
    else
      render json: @question_answer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @question_answer.destroy
    head :no_content
  end

  # GET /question_answers/for_question/:question_id
  def for_question
    @question_answers = QuestionAnswer.where(question_id: params[:question_id])
    render json: @question_answers, each_serializer: QuestionAnswerSerializer
  end

  private

  def set_question_answer
    @question_answer = QuestionAnswer.find(params[:id])
  end

  def question_answer_params
    params.require(:question_answer).permit(:user_id, :question_id, :body)
  end
end
