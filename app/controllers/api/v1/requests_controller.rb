module Api
	module V1
		class Api::V1::RequestsController < Api::ProtectedResourceController
			before_filter(only: :create) { authenticate_user }
			before_filter(only: :update) { |c| authorize! c.action_name.to_sym, current_request }

			# Create a request for a driver from authenticated user
			def create
				@pending_request = PendingRequest.new(request_params)
				render_invalid_action(@pending_request) unless @pending_request.submit

				# relay user info(location, destination, user_id, request_id) to driver
			end

			# Update the request with driver's response
			def update
				@request.finish_pending_request!(update_params)
				# relay response(:accepted...) to user				
			end

			private

			def current_request
				@request ||= PendingRequest.retrieve(params[:id].to_i)
			end

			def request_params
				params[:user_id] = current_user.id
				params.permit(:user_id, :driver_id)
			end

			def update_params
				params.permit(:accepted)
			end

		end
	end
end