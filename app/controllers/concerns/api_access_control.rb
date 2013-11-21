require 'active_support/concern'

# Provides API access control methods such as authentication and 
# authorization for resources
module ApiAccessControl

	extend ActiveSupport::Concern

	included do
		# prepend_before_filter { @user = get_user_by_token }
	end

	private 

	# Authorizes the user by the lambda method provided
	# Renders an unauthorized message in json if the lambda test fails
	# ==== Attributes
	# *+lmbda+ - the lambda method authorizes the current user by a supplied test	
	def authorize_user_on(lmda)
		current_user = get_user_by_token
		render_unauthorized_msg unless current_user && lmda.call(current_user)
	end

	# Authenticates the user by the authentication token
	def authenticate_user
		render_unauthorized unless current_user
	end

	# Authorizes the user by id
	# The user's id should equal the id in parameters
	# Renders an unauthorized message in json if the test fails
	def authorize_user_by_id
		render_unauthorized_msg unless current_user && current_user.id == params[:id].to_i
	end

	def current_user
		@USER ||= get_user_by_token
	end

	# Returns the user associated with the authentication token
	# Returns nil if authentication token is invalid
	def get_user_by_token
		user_token = auth_token
		user_token && User.find_by(authentication_token: user_token)
	end

	# Returns the authentication token from the request header
	def auth_token
		request.headers['X-AUTH-TOKEN']
	end

end