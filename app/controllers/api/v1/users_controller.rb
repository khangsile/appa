module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedApiController
			respond_to :json

			before { @user.find(params[:id]) }

			def show
				if current_user?
					render json: user, status: :ok 			
				else
					render_unauthorized_msg
				end
			end

			def edit
				if current_user?
					@user.update_attributes(params[:user_info])
				else
					render_unauthorized_msg
				end 
			end

			private

			def current_user?
				@user.authentication_token == params[:auth_token]
			end

		end
	end
end

