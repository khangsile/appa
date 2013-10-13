include ApiHelper

module Api
	module V1
		class Api::V1::SessionsController < Api::ProtectedResourceController
			# before_filter :authenticate_user_from_token!, except: [:create]
			before_filter :ensure_user_login_param_exists, only: [:create]
			# before_filter :ensure_email_param_exists, only: [:create]
			# before_filter :ensure_password_param_exists, only: [:create]
			respond_to :json

			def create
				resource = User.find_for_database_authentication(email: params[:email].downcase)
				
				if resource && resource.valid_password?(params[:user_login][:password])
					resource.ensure_authentication_token!
					@user = resource
				else
					invalid_login_attempt
				end
			end

			def destroy
				@user.reset_authentication_token!
				render json: { success: true }, status: :ok
			end

			protected

			def ensure_user_login_param_exists
				ensure_param_exists(:user_login)
			end

			def ensure_param_exists(param)
				return unless params[param].blank?
				render json:{ success: false, message: "Missing #{param} parameter"}, status: :unprocessable_entity
			end

			def invalid_login_attempt
				render json: { success: false, message: "Error with your login or password"}, status: :unauthorized
			end

		end

	end
end
