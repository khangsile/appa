module Api
	module V1
		class CommentsController < Api::ProtectedResourceController
			before_filter { authenticate_user! }
			load_resource :post, only: :create
			load_and_authorize_resource :comment, through: :post, shallow: true

			def destroy
				@comment.delete
				render_success
			end

			def create
				@comment = @post.comments.create(create_comments_params)
				render 'api/v1/comments/comment'
			end

			def update
				@comment.update(update_comments_params)
				render 'api/v1/comments/comment'
			end

			private

			def create_comments_params
				{user_id: current_user.id, content: params[:content]}				
			end

			def update_comments_params
				params.permit(:content)
			end
		end
	end
end
