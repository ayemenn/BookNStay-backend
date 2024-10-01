module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        # Skip CSRF protection for API requests
        skip_before_action :verify_authenticity_token
        before_action :require_no_authentication, only: [:create]

        # Handle user sign-up with Devise-JWT
        def create
          build_resource(sign_up_params)
          resource.save

          if resource.persisted?
            if resource.active_for_authentication?
              render json: { token: request.env['warden-jwt_auth.token'], user: resource }, status: :ok
            else
              expire_data_after_sign_in!
              render json: { error: 'Account is not active' }, status: :unprocessable_entity
            end
          else
            clean_up_passwords resource
            set_minimum_password_length
            render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # Override the update method if you need to handle updates for your API
        def update
          resource = User.find(params[:id])
          resource.update(update_params)

          if resource.errors.empty?
            render json: { user: resource }, status: :ok
          else
            render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        # Use strong parameters for sign-up
        def sign_up_params
          params.require(:user).permit(:name, :age, :phone_no, :email, :password, :password_confirmation)
        end

        # Use strong parameters for update
        def update_params
          params.require(:user).permit(:name, :age, :phone_no, :email, :password, :password_confirmation)
        end
      end
    end
  end
end
