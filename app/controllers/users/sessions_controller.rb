class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    email = params[:user][:email]
    type = params[:user][:type] # Expecting 'Mentor' or 'Mentee'

    user = User.find_by(email: email, type: type)

    if user && user.valid_password?(params[:user][:password])
      sign_in(user)
      render json: UserSerializer.new(user).serializable_hash, status: :ok
    else
      render json: { error: "Invalid email, password, or type" }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: UserSerializer.new(resource).serializable_hash, status: :created
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
