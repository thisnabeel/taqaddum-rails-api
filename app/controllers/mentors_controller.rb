class MentorsController < ApplicationController
  before_action :set_mentorship, only: %i[ dashboard ]

  def dashboard
    render json: @mentor.dashboard
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentorship
      @mentor = Mentor.find(params[:id])
    end

end
