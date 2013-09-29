module Api
	module V1
		class Api::V1::RequestController < Api::ProtectedApiController
			respond_to :json

			def create
				@pending_request = PendingRequest.new(params[:request])
				# relay user info(location, destination, user_id, request_id) to driver
			end

			def stage
				driver = Driver.find(params[:auth_token])
				if PendingRequest.retrieve(params[:id]).driver_id == driver.id
					@pending_request = PendingRequst.finish_pending_request(params[:id],
						params[:request],params[:trip])
				else
					render_unauthorized_msg
				end
			end

		end
	end
end