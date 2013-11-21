module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedResourceController
			load_and_authorize_resource :user

			# Create a new user
			def create
				@user = User.create!(create_user_params)
			end

			def show
			end

			def update
				@user.update!(user_params)
			end

			private

			def user_params
				params.permit(:email,:first_name,:last_name)
			end

			def create_user_params
				params.permit(:email,:first_name,:last_name,:password,:password_confirmation)
			end

		end
	end
end
