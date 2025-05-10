module Users
  class LeadsController < ApplicationController
    def index
      @leads = User.where.not(preapproval_token: nil)
      render json: @leads
    end

    def show
      lead = User.find_by(preapproval_token: params[:token])
      if lead
        render json: lead, status: :ok
      else
        render json: { error: 'Lead not found.' }, status: :not_found
      end
    end

    def destroy
      lead = User.find(params[:id])
      if lead.destroy
        render json: { message: 'Lead successfully deleted.' }, status: :ok
      else
        render json: { error: 'Failed to delete lead.' }, status: :unprocessable_entity
      end
    end
  end
end