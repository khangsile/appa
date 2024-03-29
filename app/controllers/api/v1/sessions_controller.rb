include ApiHelper

module Api
	module V1
		class Api::V1::SessionsController < Api::ProtectedResourceController
			# before_filter(only: :destroy) { render_unauthorized if current_user.nil? }
			before_filter(only: [:show,:destroy,:me]) { authenticate_user! }

			# If valid login, create an authentication token for subsequent requests
			# Otherwise, render invalid login attempt
			def create
				resource = User.find_for_database_authentication(email: params.require(:email).downcase)
				
				if resource && resource.valid_password?(params.require(:password))
					resource.ensure_authentication_token!					
					@user = resource
					update_device
				else
					render_invalid_login
				end
			end

			def me
				Rails.logger.info request.headers['X-AUTH-TOKEN']
				@user = current_user
				render 'api/v1/sessions/create'
			end

			def facebook_login
				fb_user = FbGraph::User.me(request.headers['OAUTH']).fetch
				# Rails.logger.info fb_user.to_yaml
				render_invalid_login and return if fb_user.identifier.blank?
				@user = User.find_by(email: fb_user.email)
				if @user.nil?
					@user = User.create!(fb_params(fb_user))
				end
				FbProfilePic.find_or_create_by!(user_id: @user.id, url: fb_user.picture)
				update_device
				@user.ensure_authentication_token!
				render 'api/v1/sessions/create'
			end

			# Destroy the session by resetting the user's authentication token
			def destroy
				current_user.reset_authentication_token!
				render_success
			end

			private

			def update_device
				device = Device.where(user_id: @user.id, platform: params[:platform]).first_or_initialize
				device.registration_id = params[:registration_id]
				device.save
			end

			def fb_params(user)
				fb = user.raw_attributes
				logger.info fb
				{first_name: fb[:first_name], last_name: fb[:last_name], email: fb[:email], 
					password: Devise.friendly_token[0,20], provider: 'facebook', uid: fb[:id]}
			end

		end
	end
end
