module Authenticatable
  extend ActiveSupport::Concern
  included do
    before_action :authenticate_user_from_token!
  end
  private
  def authenticate_user_from_token!
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      begin
        jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
        @current_user = User.find(jwt_payload['sub'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        @current_user = nil
      end
    else
      begin
        @is_missing_auth_token = true
        @current_user = nil
      end
    end
  end
end









