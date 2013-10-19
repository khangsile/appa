module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedResourceController
			before_filter(only: :update) { authorize_user_by_id }

			def show
				render_not_found unless @user = User.where(id: params[:id]).first
			end

			def update
				render_invalid_action(@user) unless @user.update(user_params)
			end

			private

			def user_params
				params.permit(:email,:first_name,:last_name)
			end

		end
	end
end
