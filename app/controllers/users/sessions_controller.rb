class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      token = JWT.encode({ user_id: resource.id }, Rails.application.secrets.secret_key_base)
      render json: {
        status: { code: 200, message: 'Logged in sucessfully.' },
        user: UserSerializer.new(resource).serializable_hash[:data][:attributes],
          token: token
      }, status: :ok

    else
      render json: {
        status:{code: 401, message: 'Not logged in.'},
        message: 'Couldnt find user.'
      }, status: :ok
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: 'logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :ok
    end
  end
end
