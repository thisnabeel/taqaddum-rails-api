class MenteeshipsController < ApplicationController
  before_action :set_menteeship, only: %i[ show update destroy ]

  # GET /menteeships
  def index
    @menteeships = Menteeship.all

    render json: @menteeships
  end

  # GET /menteeships/1
  def show
    render json: @menteeship
  end

  # POST /menteeships
  def create
    @menteeship = Menteeship.new(menteeship_params)

    if @menteeship.save
      render json: @menteeship, status: :created, location: @menteeship
    else
      render json: @menteeship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menteeships/1
  def update
    if @menteeship.update(menteeship_params)
      render json: @menteeship
    else
      render json: @menteeship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menteeships/1
  def destroy
    @menteeship.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menteeship
      @menteeship = Menteeship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menteeship_params
      params.require(:menteeship).permit(:user_id, :skill_id, :summary)
    end
end
