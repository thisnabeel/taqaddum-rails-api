class MenteesController < ApplicationController
  before_action :set_menteesship, only: %i[ dashboard ]

  def dashboard
    render json: @mentees.dashboard
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menteesship
      @mentees = Mentee.find(params[:id])
    end

end
