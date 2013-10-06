module Api
	module V1
		class Api::V1::RequestsController < Api::ProtectedResourceController
			respond_to :json

			def create
				begin 
					Driver.find(params[:request][:driver_id])
					@pending_request = PendingRequest.new(request_params)
					# relay user info(location, destination, user_id, request_id) to driver
				rescue
					render_unauthorized_msg
				end
			end

			def update
				user = User.find_by_authentication_token(params[:auth_token])
				# stage request if the driver is the target of the request
				if PendingRequest.retrieve(params[:id]).driver_id == user.driver.id
					@pending_request = PendingRequst.finish_pending_request(params[:id],
						params[:request])
				else
					render_unauthorized_msg
				end
			end

			private

			def request_params
				params.require(:request).permit(:user_id, :driver_id)
			end

		end
	end
end