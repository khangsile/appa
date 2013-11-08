
# Provides standard JSON responses that can be called in the controller
module ApiHelper

	def render_success
		render json: { success: true }, status: :ok
	end

	def render_unauthorized
		render json: { success: false, message: "Unauthorized access" }, status: :unauthorized
	end

	def render_not_found
		render json: { success: false, message: "Resource not found" }, status: :not_found
	end

	def render_invalid_action(resource)
		render json: { success: false, errors: resource.errors.messages }, 
			status: :method_not_allowed
	end

	def render_invalid_login
		render json: { success: false, message: "Error with your login or password"}, status: :unauthorized
	end

end