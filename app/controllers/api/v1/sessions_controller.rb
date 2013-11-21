include ApiHelper

module Api
	module V1
		class Api::V1::SessionsController < Api::ProtectedResourceController
			before_filter(only: :destroy) { render_unauthorized if current_user.nil? }

			# If valid login, create an authentication token for subsequent requests
			# Otherwise, render invalid login attempt
			def create
				resource = User.find_for_database_authentication(email: params.require(:email).downcase)
				
				if resource && resource.valid_password?(params.require(:password))
					resource.ensure_authentication_token!					
					@user = resource
					device = Device.where(user_id: @user.id, platform: params[:platform]).first_or_initialize
					device.registration_id = params[:registration_id]
					device.save
				else
					render_invalid_login
				end
			end

			def facebook_login
				fb = JSON.parse(request.env['omniauth.auth']);
				token = fb[:credentials][:token]
				fb_user = FbGraph::User.me(token)
				if user
					@user = User.find_by(email: fb_user.email)
					@user.ensure_authentication_token!
				end
			end

			# Destroy the session by resetting the user's authentication token
			def destroy
				current_user.reset_authentication_token!
				render_success
			end

		end
	end
end
