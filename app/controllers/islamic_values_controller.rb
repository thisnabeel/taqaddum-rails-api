class IslamicValuesController < ApplicationController
  before_action :set_islamic_value, only: %i[ show update destroy ]

  # GET /islamic_values
  def index
    @islamic_values = IslamicValue.all

    render json: @islamic_values
  end

  # GET /islamic_values/1
  def show
    render json: @islamic_value
  end

  # POST /islamic_values
  def create
    @islamic_value = IslamicValue.new(islamic_value_params)

    if @islamic_value.save
      render json: @islamic_value, status: :created, location: @islamic_value
    else
      render json: @islamic_value.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /islamic_values/1
  def update
    if @islamic_value.update(islamic_value_params)
      render json: @islamic_value
    else
      render json: @islamic_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /islamic_values/1
  def destroy
    @islamic_value.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_islamic_value
      @islamic_value = IslamicValue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def islamic_value_params
      params.require(:islamic_value).permit(:title, :description)
    end
end
