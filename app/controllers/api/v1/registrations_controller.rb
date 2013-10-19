module Api
	module V1
		class Api::V1::RegistrationsController < Api::ProtectedResourceController
			before_filter(only: :create_driver) { authenticate_user }
			
			def create
				@user = User.new(user_params)
				unless @user.save
					warden.custom_failure!
					# render json: @user.errors.messages, status: :unprocessable_entity
					render_invalid_action(@user)
				end
			end

			def create_driver
				if @user.driver
					render_unauthorized_msg
				else
					@user.create_driver(driver_params)
					render json: { success: true }, status: :ok
				end
			end

			private

			def user_params
				params.permit(:first_name, :last_name, 
					:email, :password, :password_confirmation)
			end

			def driver_params
				params.permit(:license)
			end

		end

	end
end