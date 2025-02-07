class ProofsController < ApplicationController
  before_action :set_proof, only: %i[ show update destroy ]

  # GET /proofs
  def index
    @proofs = Proof.all

    render json: @proofs
  end

  # GET /proofs/1
  def show
    render json: @proof
  end

  # POST /proofs
  def create
    @proof = Proof.new(proof_params)

    if @proof.save
      render json: @proof, status: :created, location: @proof
    else
      render json: @proof.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /proofs/1
  def update
    if @proof.update(proof_params)
      render json: @proof
    else
      render json: @proof.errors, status: :unprocessable_entity
    end
  end

  # DELETE /proofs/1
  def destroy
    @proof.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proof
      @proof = Proof.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proof_params
      params.require(:proof).permit(:mentorship_id, :menteeship_id, :position)
    end
end
