module ApiHelper

	def render_unauthorized_msg
		render 'api/v1/errors/unauthorized', status: :unauthorized
	end

	def render_invalid_action(resource)
		render json: { success: false, errors: resource.errors.messages }, 
			status: :method_not_allowed
	end

end