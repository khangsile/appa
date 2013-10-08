module Api
	module V1
		class Api::V1::RequestsController < Api::ProtectedResourceController
			before_filter(only: :update) { authorize_user_on method(:is_driver_of_request?) }

			def create
				begin
					params[:request][:user_id] = @user.id unless !params[:request].blank?
					@pending_request = PendingRequest.new(request_params)
					render_invalid_action(@pending_request) unless @pending_request.store

					# relay user info(location, destination, user_id, request_id) to driver
					# render_unauthorized_msg
				end
			end

			def update
				@pending_request = PendingRequst.finish_pending_request(params[:id],
					params[:request])
			end

			private

			def is_driver_of_request?(user)
				@pending_request = PendingRequest.retrieve(params[:id])
				@pending_request.driver_id == user.driver.id
			end

			def request_params
				params.require(:request).permit(:user_id, :driver_id)
			end

		end
	end
end