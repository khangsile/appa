module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedApiController
			respond_to :json

			def user
				user = User.find(1)
				render json: user.as_json(), status: :ok
			end
		end
	end
end

