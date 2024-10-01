module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        # Skip CSRF protection for API requests
        skip_before_action :verify_authenticity_token
        before_action :require_no_authentication, only: :create

        # Handle sign-in with Devise-JWT
        def create
          self.resource = warden.authenticate!(auth_options)
          sign_in(resource_name, resource)
          render json: {
            token: request.env['warden-jwt_auth.token'],
            user: resource
          }, status: :ok
        end

        # Handle sign-out with JWT
        def destroy
          if current_user
            current_user.update!(jti: SecureRandom.uuid) # Invalidate the JWT token
            render json: { message: 'Signed out successfully' }, status: :ok
          else
            render json: { error: 'User not signed in' }, status: :unauthorized
          end
        end

        private

        # Use the Devise authentication options for JWT
        def auth_options
          { store: false, recall: 'sessions#create' }
        end
      end
    end
  end
end
