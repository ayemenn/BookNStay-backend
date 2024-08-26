class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  # skip_before_action :verify_authenticity_token, if: :devise_controller?
  def flash
    # Return an empty hash or a mock flash object
    {}
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :password, :password_confirmation, :phone_no, :age])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :password, :password_confirmation, :phone_no, :age])
    devise_parameter_sanitizer.permit(:password_change, keys: [:password, :password_confirmation, :reset_password_token])
  end
end