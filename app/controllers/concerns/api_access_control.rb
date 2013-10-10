require 'active_support/concern'

module ApiAccessControl
	extend ActiveSupport::Concern

	included do
		prepend_before_filter { @user = get_user_by_token }
	end

	def authorize_user_on(lmda)
		render_unauthorized_msg unless @user && lmda.call(@user)
	end

	def authorize_user_by_id
		render_unauthorized_msg unless @user && @user.id = Integer(params[:id])
	end

	def get_user_by_token
		user_token = params[:auth_token].presence
		user = user_token && User.where(authentication_token: user_token).first
	end

end