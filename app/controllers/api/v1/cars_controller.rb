module Api
	module V1
		class DriverReviewsController < Api::ProtectedResourceController
			before_filter(only: :create) { |c| authorize! c.action_name.to_sym, current_driver }

			# Create a car for driver only if user is a driver
			def create
				current_driver.create_car(car_params)
			end

			private

			def car_params
				params.permit(:make, :model, :year, :num_seats)
			end

			def current_driver
				@driver ||= Driver.find_by(id: params[:driver_id])
			end

		end
	end
end