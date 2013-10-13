module Api
	module V1
		class DriversController < Api::ProtectedResourceController
			# before_filter(only: :update) { authorize_user_on method(:is_driver?) }

			def show
				driver = Driver.where(id: params[:id]).first
				@user = driver.user if driver
			end

			private

			def is_driver?(user)
				params[:id].to_i == user.driver.id
			end

		end
	end
end
