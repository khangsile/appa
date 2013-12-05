require 'trip_search/geo/location'

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
				build_locs.merge params.permit(:description,:cost,
					:min_seats,:start_time,tag_list: [])
			end

			def build_locs
				st = TripSearch::Geo::Location.new(params[:start_location])
				ed = TripSearch::Geo::Location.new(params[:end_location])
				stp = st.invalid_point? ? nil : st.coord
				edp = ed.invalid_point? ? nil : ed.coord
				params[:tag_list] += [st.title, ed.title]
				{start_location: stp, end_location: edp}
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
