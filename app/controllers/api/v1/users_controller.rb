module Api
	module V1
		class Api::V1::UsersController < Api::ProtectedUserController
			respond_to :json			

			def show		
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
