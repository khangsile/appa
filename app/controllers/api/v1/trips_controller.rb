require 'trip_search/geo/location'

module Api
	module V1
		class TripsController < Api::ProtectedResourceController
			before_filter(except: [:show,:index]) { authenticate_user! }
			load_and_authorize_resource :trip

			def show
				render 'api/v1/trips/trip'
			end

			def create
				@trip = current_user.trips.create!(trip_params)
				Rails.logger.info @trip.errors.messages 
				# render 'api/v1/trips/trip'
			end

			def update
				@trip.update!(update_trip_params)
				render 'api/v1/trips/trip'
			end

			private

			def trip_params
				params[:start_time] = DateTime.parse(params[:start_time])
				Rails.logger.info params[:start_time]
				build_coords.merge params.permit(:description,:cost,
					:min_seats,:start_time,tag_list: [])
			end

			def build_coords
				Rails.logger.info params[:start_location]
				start = TripSearch::Geo::Location.new(params[:start_location])
				dest = TripSearch::Geo::Location.new(params[:end_location])

				{start_location: start.coord, end_location: dest.coord,
					start_title: start.title, end_title: dest.title}
			end

			def update_trip_params
				params.permit(:description, :cost, :min_seats, tag_list: [])
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
