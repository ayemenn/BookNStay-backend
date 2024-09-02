class AuthController < ApplicationController
  
    include Authenticatable

    def verify
      if @current_user
        render json: {
          status: { code: 200, message: 'Token is valid' },
          data: {
            email: @current_user.email,
            name: @current_user.name,
            # Include other user fields as needed
          }
        }, status: :ok
      else
        if @is_missing_auth_token
          render json: { status: 401, message: 'missing token' }, status: :unauthorized
        else
          render json: { status: 401, message: 'Invalid or expired token' }, status: :unauthorized
        end
      end
    end
  end
  
  
  
  
  
  
  