module Api
	module V1
		class DriversController < Api::ProtectedUserController
			respond_to :json

			def show
			end

			def update
				if @user.update_attributes(user_params) && @user.driver.update_attributes(driver_params)
					render 'api/v1/drivers/show'
				else
					render_invalid_action(@user)
				end
			end

			private

			def user_params
				params.require(:user).permit(:email)
			end

			def driver_params
				params.require(:user).require(:driver).permit(:balance)
			end

		end
	end
end
