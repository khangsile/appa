module Api
	module V1
		class TripsController < Api::ProtectedResourceController
			before_filter(except: [:show,:index]) { authenticate_user! }
			load_and_authorize_resource :trip

			def index
				# @trips = Trip.tagged_with(params[:tag_list])
				@trips = trip_search
			end

			def show
				render 'api/v1/trips/trip'
			end

			def create
				@trip = current_user.trips.create!(trip_params)
				render 'api/v1/trips/trip'
			end

			def update
				@trip.update!(update_trip_params)
				render 'api/v1/trips/trip'
			end

			private

			def trip_params
				params.permit(:description, :cost, :min_seats, :start_time, tag_list: [])
			end

			def update_trip_params
				params.permit(:description, :cost, :min_seats, tag_list: [])
			end

			def trip_search
				Trip.tagged_with(params[:tag_list])
					.starts_within(st_loc[:longitude],st_loc[:latitude],st_loc[:distance])
					.ends_within(end_loc[:longitude],end_loc[:latitude],end_loc[:distance])
			end

			def st_loc
				params[:start_location]
			end

			def end_loc
				params[:end_location]
			end

		end
	end
end
