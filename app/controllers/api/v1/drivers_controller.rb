module Api
	module V1
		class DriversController < Api::ProtectedResourceController
			before_filter(only: :create) { authenticate_user }
			before_filter(only: [:update,:update_location]) { |c| authorize! c.action_name.to_sym, current_driver }


			# Get drivers within given bounding box coordinates
			def index
				@drivers = Driver.includes(:user).within(params[:left], params[:bottom], params[:right], params[:top])				
			end

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
					@driver = current_user.create_driver(driver_params)
				else
					current_user.driver.errors[:driver] << "already exists"
					render_invalid_action(current_user.driver)
				end
				logger.debug current_user.driver.to_yaml
			end

			def update_location
				factory = Driver.rgeo_factory_for_column(:location)
				if factory.is_a?(Proc)
					factory = factory.call({})
				end				
				current_driver.update(location: factory.point(params[:lon].to_f,params[:lat].to_f))
			end

			private

			def driver_params
				params.permit(:fee,:active)
			end

			def location_params
				params.permit([:lat,:lon])
			end

			def current_driver
				@driver ||= get_driver
			end

			def get_driver
				if(params[:driver_id].blank?)
					Driver.includes(:user).find_by!(id: params[:id])
				else
					Driver.includes(:user).find_by!(id: params[:driver_id])
				end
			end
		end
	end
end
