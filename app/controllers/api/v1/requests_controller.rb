module Api
	module V1
		class Api::V1::RequestsController < Api::ProtectedResourceController
			before_filter { authenticate_user! }
			load_resource :trip, only: :create
			load_and_authorize_resource :request, through: :trip, shallow: true, except: :index

			def index
				case params[:type]
				when 'incoming'
					Rails.logger.info 'incoming'
					@requests = current_user.incoming_requests
				when 'outgoing'
					Rails.logger.info 'outgoing'					
					@requests = current_user.requests
				end
			end

			def create
				@trip.requests.create!(user_id: current_user.id)
				render_success
			end

			def update
				Rails.logger.info 'ANSWER REQUEST!'
				@request.answer!(params.permit(:accepted))
			end

			private

			# before_filter(only: :update) { |c| authorize! c.action_name.to_sym, current_request }
			
			# # # Custom error and authorization to create a request due to issues with cancan
			# # before_filter(only: :create) do
			# # 	driver = Driver.find_by(id: params[:driver_id])
			# # 	# Driver_id must exist and driver must be active
			# # 	render_not_found and return unless !driver.nil? && driver.active
			# # 	authenticate_user
			# # end
			# load_resource :driver, only: :create
			# authorize_resource :request, through: :driver, only: :create, singleton: true

			# # Custom authorization for index because of issues with cancan
			# before_filter(only: :index) do
			# 	render_unauthorized unless target_user.id == current_user.id
			# end


			# # Get a user's requests
			# def index
			# 	# user = User.find_by!(id: params[:user_id])
			# 	# authorize! :index, Request, user
			# 	@requests = target_user.requests
			# end

			# # Create a request for a driver from authenticated user and corresponding trip
			# def create
			# 	Rails.logger.info @driver.to_yaml
			# 	@pending_request = PendingRequest.new(request_params)
			# 	@pending_request.create_trip(trip_params)
			# 	# submit the request to Resque to push to driver
			# 	render_invalid_action(@pending_request) unless @pending_request.submit
			# end

			# # Update the request with driver's response
			# def update
			# 	render_invalid_action(@request) unless @request.finish_pending_request!(update_params)
			# end

			# private

			# def target_user
			# 	@target_user ||= User.find_by!(id: params[:user_id])
			# end

			# def trip_params
			# 	factory = Trip.rgeo_factory_for_column(:start_location)
			# 	start_location = factory.point(params[:start][:lon].to_f, params[:start][:lat].to_f)
			# 	end_location = factory.point(params[:end][:lon].to_f, params[:end][:lat].to_f)
			# 	{start_location: start_location, end_location: end_location}
			# end

			# def current_request
			# 	@request ||= PendingRequest.retrieve(params[:id].to_i)
			# end

			# def request_params
			# 	params[:user_id] = current_user.id
			# 	params.permit(:user_id, :driver_id)
			# end

			# def update_params
			# 	params.permit(:accepted)
			# end

		end
	end
end