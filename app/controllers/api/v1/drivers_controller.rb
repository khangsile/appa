module Api
	module V1
		class DriversController < Api::ProtectedResourceController
			before_filter(only: :update) { authorize_user_on method(:is_driver?) }
			before_filter(only: :create) { authenticate_user }

			# Update the driver
			# If driver updates don't pass validation, render invalid action
			def update
				render_invalid_action(current_driver) unless current_driver.update(driver_params)
			end

			# Get the driver
			# If the driver is not found, render not found
			def show
				render_not_found unless current_driver && @user = current_driver.user
			end

			# Create a driver
			# If the user has a driver, render invalid action
			def create
				if @user.driver
					render_unauthorized_msg
				else
					@driver = @user.create_driver
					render_invalid_action(@driver) unless @driver.save
				end
			end

			private

			def driver_params
				params.permit(:fee)
			end

			def current_driver
				@driver ||= Driver.includes(:user).where(id: params[:id]).first
			end

			def is_driver?(user)
				params[:id].to_i == user.driver.id
			end

		end
	end
end
