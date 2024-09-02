class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    token = JWT.encode({ sub: current_user.id }, Rails.application.credentials.devise_jwt_secret_key!, 'HS256')

    render json: {
      status: { 
        code: 200, message: 'Logged in successfully.',
        data: { 
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
          token: token # Include token in the response
        }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200, 
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
