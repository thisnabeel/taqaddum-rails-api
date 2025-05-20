module Users
  class PreapprovalsController < ApplicationController
    def update
      user = User.find_by(preapproval_token: params[:token])
      
      if user.nil?
        return render json: { error: 'User not found' }, status: :not_found
      end

      # Update avatar if provided
      if params[:avatar].present?
        user.upload_avatar(params)
      end

      # Update password if provided
      if params[:password].present?
        user.password = params[:password]
      end

      # Clear the preapproval token and set converted_at timestamp
      user.preapproval_token = nil
      user.converted_at = Time.current

      user.mentorships.each do |mentorship|
        mentorship.update(status: "approved")
      end

      if user.save
        render json: UserSerializer.new(user).serializable_hash, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end 