require 'active_support/concern'

module AccessControl
	extend ActiveSupport::Concern

	included do
		# prepend_before_filter { @user = get_user_by_token }
	end

	# private 

	def authorize_user_on(lmda)
		@user = get_user_by_token
		render_unauthorized_msg unless @user && lmda.call(@user)
	end

	def authenticate_user
		@user = get_user_by_token
		render_unauthorized_msg unless @user
	end

	def authorize_user_by_id
		@user = get_user_by_token
		render_unauthorized_msg unless @user && @user.id = Integer(params[:id])
	end

	def get_user_by_token
		user_token = get_auth_token
		user = user_token && User.find_by_authentication_token(user_token)
	end

	def get_auth_token
		request.headers['X-AUTH-TOKEN']
	end

end