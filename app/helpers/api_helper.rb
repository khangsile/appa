module ApiHelper

	def authenticate_user_from_token!
		user_token = params[:auth_token].presence
		user = user_token && User.find_by_authentication_token(user_token)

		if user.nil?
			render json: { success: false, message: "Unauthorized access"}, status: :unauthorized
			return				
		end
	end

end