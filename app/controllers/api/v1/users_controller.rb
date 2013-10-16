module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedResourceController
			before_filter(only: :update) { authorize_user_by_id }

			def show
				@user = User.where(id: params[:id]).first
			end

			def update
				if @user.update_attributes(user_params) 
					render 'api/v1/users/edit'
				else
					render_invalid_action(@user)
				end
			end

			private

			def user_params
				params.permit(:email)
			end

			def driver_params
				params.require(:driver).permit(:balance)
			end

		end
	end
end
