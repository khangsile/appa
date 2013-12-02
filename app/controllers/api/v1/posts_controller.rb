module Api
	module V1
		class PostsController < Api::ProtectedResourceController
			load_and_authorize_resource :trip, only: :create
			load_and_authorize_resource :post, through: :trip, shallow: true

			def create
				@post = @trip.posts.create!(user_id: current_user.id, content: params[:content])
				render 'api/v1/posts/post'
			end

			def update
				@post.update!(params.permit(:content))
				render 'api/v1/posts/post'
			end

			def show
				render 'api/v1/posts/post'
			end

		end
	end
end