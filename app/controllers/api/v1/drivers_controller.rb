module Api
	module V1
		class DriversController < Api::ProtectedResourceController
			before_filter(only: [:update, :update_location]) { authorize_user_on method(:is_driver?) }

			def show
			end

			def update
				if @user.update_attributes(user_params) && @user.driver.update_attributes(driver_params)
					render 'api/v1/drivers/show'
				else
					render_invalid_action(@user)
				end
			end

			def update_location
				factory = Driver.rgeo_factory_for_column(:location)
				@user.driver.update_attribute(:location,factory.point(params[:lon].to_f,params[:lat].to_f))
			end

			private

			def is_driver?(user)
				Integer(params[:id]) == user.id
			end

			def location_params
				params.permit([:lat,:lon])
			end

			def user_params
				params.require(:user).permit(:email)
			end

			def driver_params
				params.require(:user).require(:driver).permit(:balance)
			end

		end
	end
end
