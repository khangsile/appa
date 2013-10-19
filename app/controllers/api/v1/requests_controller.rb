module Api
	module V1
		class Api::V1::RequestsController < Api::ProtectedResourceController
			before_filter(only: :update) { authorize_user_on method(:is_driver_of_request?) }
			before_filter(only: :create) { authenticate_user }

			# Create a request for a driver from authenticated user
			def create
				begin
					params[:user_id] = @user.id 
					@pending_request = PendingRequest.new(request_params)
					render_invalid_action(@pending_request) unless @pending_request.store

					# relay user info(location, destination, user_id, request_id) to driver
					# render_unauthorized_msg
				end
			end

			# Answer the request according to driver's response
			def update
				@request = PendingRequest.where(id: params[:id]).first
				@request.finish_pending_request!(update_params)
			end

			private

			def is_driver_of_request?(user)
				@pending_request = PendingRequest.retrieve(params[:id])
				@pending_request.driver_id == user.driver.id
			end

			def request_params
				params.permit(:user_id, :driver_id)
			end

			def update_params
				params.permit(:accepted)
			end

		end
	end
end