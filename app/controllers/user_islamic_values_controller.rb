class UserIslamicValuesController < ApplicationController
  before_action :set_user_islamic_value, only: %i[ show update destroy ]

  # GET /user_islamic_values
  def index
    @user_islamic_values = UserIslamicValue.all

    render json: @user_islamic_values
  end

  # GET /user_islamic_values/1
  def show
    render json: @user_islamic_value
  end

  # POST /user_islamic_values
  def create
    @user_islamic_value = UserIslamicValue.new(user_islamic_value_params)

    if @user_islamic_value.save
      render json: @user_islamic_value, status: :created, location: @user_islamic_value
    else
      render json: @user_islamic_value.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_islamic_values/1
  def update
    if @user_islamic_value.update(user_islamic_value_params)
      render json: @user_islamic_value
    else
      render json: @user_islamic_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_islamic_values/1
  def destroy
    @user_islamic_value.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_islamic_value
      @user_islamic_value = UserIslamicValue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_islamic_value_params
      params.require(:user_islamic_value).permit(:islamic_value_id, :user_id, :summary)
    end
end
