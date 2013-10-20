module Api
	module V1
		class DriverReviewsController < Api::ProtectedResourceController
			# before_filter(only: :create) { authorize_user_on method(:is_owner_of_request?) }
			# before_filter(only: [:update, :destroy]) { authorize_user_on method(:is_owner_of_review?) }
			load_and_authorize_resource

			# Create a driver review
			# If validations are not passed, render invalid action
			def create
				@review = DriverReview.new(create_driver_review_params)
				render_invalid_action(@review) unless @review.save
				# Rabl::Renderer.json(@review, 'api/v1/driver_reviews/review')
			end

			# Update the driver review unless the unless validations do not pass
			def update
				render_invalid_action(current_review) unless current_review.update(update_driver_review_params)
				# Rabl::Renderer.json(@review, 'api/v1/driver_reviews/review')
			end

			# Deletes the driver review
			def destroy
				DriverReview.destroy(current_review)
				render_success
			end

			def show
				render_not_found unless current_review
			end

			private

			def current_review
				@review ||= DriverReview.includes(request: [:user]).where(id: params[:id]).first
			end

			def current_request
				@request ||= Request.where(id: params[:request_id]).first
			end

			def is_owner_of_request?(user)
				current_request && (current_request.user_id == user.id)
			end

			def is_owner_of_review?(user)
				current_review && current_review.request.user_id == user.id
			end

			def create_driver_review_params
				params.permit(:request_id,:content,:rating)
			end

			def update_driver_review_params
				params.permit(:content,:rating)
			end

		end
	end
end