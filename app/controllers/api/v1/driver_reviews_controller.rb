module Api
	module V1
		class DriverReviewsController < Api::ProtectedResourceController
			before_filter(only: :create) { authorize_user_on method(:is_owner_of_request?) }
			before_filter(only: :update) { authorize_user_on method(:is_owner_of_review?) }

			def create
				@review = DriverReview.new(create_driver_review_params)
				render_invalid_action(@review) and return unless @review.save
				render 'api/v1/driver_reviews/show'
			end

			def update
				render_invalid_action(@review) and return unless @review.update(update_driver_review_params)
				render 'api/v1/driver_reviews/show'
			end

			private

			def is_owner_of_request?(user)
				request = Request.where(id: params[:driver_review][:request_id]).first
				request && (request.user_id == user.id)
			end

			def is_owner_of_review?(user)
				@review = DriverReview.where(id: params[:id]).first
				@review && @review.request.user_id == user.id
			end

			def create_driver_review_params
				params.require(:driver_review).permit(:request_id,:content,:rating)
			end

			def update_driver_review_params
				params.require(:driver_review).permit(:content,:rating)
			end
		end
	end
end