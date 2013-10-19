include ApiHelper

module Api
	module V1
		class Api::V1::SessionsController < Api::ProtectedResourceController
			respond_to :json

			# If valid login, create an authentication token for subsequent requests
			# Otherwise, render invalid login attempt
			def create
				resource = User.find_for_database_authentication(email: params.require(:email).downcase)
				
				if resource && resource.valid_password?(params.require(:password))
					resource.ensure_authentication_token!
					@user = resource
				else
					render_invalid_login
				end
			end

			# Reset the session by resetting the user's authentication token
			def destroy
				@user.reset_authentication_token!
				render json: { success: true }, status: :ok
			end

		end
	end
end
