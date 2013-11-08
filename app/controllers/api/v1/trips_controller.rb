module Api
	module V1
		class TripsController < Api::ProtectedResourceController

			def update
				Trip.update(trip_params)
			end

			private

			def trip_params
				params.permit(:completed)
			end

		end
	end
end
