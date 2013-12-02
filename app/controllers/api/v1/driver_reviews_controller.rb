module Api
	module V1
		class DriverReviewsController < Api::ProtectedResourceController
			# before_filter(only: :create) { authenticate_user }
			before_filter(only: [:update,:destroy]) { |c| authorize! c.action_name.to_sym, current_review }
			load_resource :request, only: :create
			authorize_resource :driver_review, through: :request, only: :create

			# Get driver reviews
			# Requires no authentication
			def index
				# @reviews = Driver.find_by!(id: params[:driver_id]).driver_reviews#.order('created_at DESC').to_a
				@reviews = DriverReview.where(driver_id: params[:driver_id])
			end

			# Create a driver review
			# If validations are not passed, render invalid action
			def create
				@review = DriverReview.new(create_driver_review_params)
				@review.driver_id = @request.driver_id
				# render_invalid_action(@review) unless @review.save
				@review.save!
				logger.debug @review.errors.messages				
			end

			# Update the driver review unless the unless validations do not pass
			def update
				render_invalid_action(current_review) unless current_review.update(update_driver_review_params)
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
				@review ||= DriverReview.includes(request: [:user]).find_by(id: params[:id])
			end

			def current_request
				@request ||= Request.find_by(id: params[:request_id])
			end

			def create_driver_review_params
				params[:user_id] = current_user.id
				params.permit(:request_id,:content,:rating,:user_id,:driver_id)
			end

			def update_driver_review_params
				params.permit(:content,:rating)
			end

		end
	end
end