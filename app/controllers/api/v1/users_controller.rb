module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedResourceController
			before_filter(only: :update) { authorize_user_by_id }

			def show
				@user = User.where(id: params[:id]).first
			end

			def update
				if @user.update_attributes(user_params)
					render 'api/v1/users/show'
				else
					render_invalid_action(@user)
				end
			end

			private

			def user_params
				params.require(:user).permit(:email)
			end

		end
	end
end
