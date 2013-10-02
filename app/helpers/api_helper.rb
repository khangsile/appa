module ApiHelper
	def authorize_user_from_token!
		user = get_user_by_token
		if user.nil? || user.id != Integer(params[:id])
			render_unauthorized_msg
		end
		return user
	end

	def authenticate_user_from_token!
		user = get_user_by_token
		if user.nil?
			render_unauthorized_msg
		end
		return user
	end

	def get_user_by_token
		user_token = params[:auth_token].presence
		user = user_token && User.find_by_authentication_token(user_token)
	end

	def render_unauthorized_msg
		render 'api/v1/errors/unauthorized', status: :unauthorized
	end

	def render_invalid_action(resource)
		render json: { success: false, errors: resource.errors.messages }, 
			status: :method_not_allowed
	end

end