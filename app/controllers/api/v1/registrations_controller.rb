module Api
	module V1
		class Api::V1::RegistrationsController < Api::BaseController
			respond_to :json

			def create
				@user = User.new(user_params)
				unless @user.save
					warden.custom_failure!
					render json: @user.errors.messages, status: :unprocessable_entity
				end
			end

			private

			def user_params
				params.require(:user).permit(:first_name, :last_name, 
					:email, :password, :password_confirmation)
			end

		end

	end
end