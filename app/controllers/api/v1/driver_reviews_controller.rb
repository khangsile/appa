module Api
	module V1
		class DriverReviewsController < Api::ProtectedResourceController
			respond_to :json
			before_filter :authorize_owner_of_request, only: [:create]
			before_filter :authorize_owner_of_review, only: [:update]

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

			def authorize_owner_of_request
				request = Request.where(id: params[:driver_review][:request_id]).first
				render_unauthorized_msg unless request && request.user_id == @user.id
			end

			def authorize_owner_of_review
				@review = DriverReview.where(id: params[:id]).first
				render_unauthorized_msg unless @review && @review.request.user_id == @user.id
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