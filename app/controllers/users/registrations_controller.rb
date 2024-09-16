class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :configure_sign_up_params, only: [:create]
  respond_to :json

  rescue_from ActiveRecord::RecordNotUnique, with: :handle_duplicate_email

  private

  def handle_duplicate_email
    render json: {
      error: 'Email already taken',
      status: {code: 422, message: "unprocessable entity"}
    }
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      token = JWT.encode({ user_id: resource.id }, Rails.application.secrets.secret_key_base)      
      render json: {
        status: { code: 200, message: 'Registered successfully.' },
        user: resource,
        token: token
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
