module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedResourceController
			before_filter(only: [:show,:update]) { |c| authorize! c.action_name.to_sym, target_user }

			def create
				@user = User.new(create_user_params)
				unless @user.save
					warden.custom_failure!					
					render_invalid_action(@user)
				end
			end

			def show
				@user = target_user
			end

			def update
				current_user.update!(user_params)
			end

			private

			def target_user
				@t_user ||= User.find_by!(id: params[:id])
			end

			def user_params
				params.permit(:email,:first_name,:last_name)
			end

			def create_user_params
				params.permit(:email,:first_name,:last_name,:password,:password_confirmation)
			end

		end
	end
end
