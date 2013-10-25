module Api
	module V1
		class DriversController < Api::ProtectedResourceController
			before_filter(only: :create) { authenticate_user }
			before_filter(only: :update) { |c| authorize! c.action_name.to_sym, current_driver }

			# Update the driver
			# If driver updates don't pass validation, render invalid action
			def update
				current_driver.update(driver_params)
			end

			# Get the driver
			# If the driver is not found, render not found
			def show
				render_not_found unless current_driver && @user = current_driver.user
			end

			# Create a driver
			# If the user has a driver, render invalid action
			def create
				if current_user.driver.nil?
					current_user.create_driver(driver_params)
				else
					current_user.driver.errors[:driver] << "already exists"
					render_invalid_action(current_user.driver)
				end
			end

			private

			def driver_params
				params.permit(:fee)
			end

			def current_driver
				@driver ||= Driver.includes(:user).find_by!(id: params[:id])
			end

		end
	end
end
