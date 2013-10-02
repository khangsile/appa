include ApiHelper

module Api
	class ProtectedUserController < Api::BaseController
		before_filter :enfore_authorization

		protected

		def enfore_authorization
			@user = authorize_user_from_token!
		end
	end
end