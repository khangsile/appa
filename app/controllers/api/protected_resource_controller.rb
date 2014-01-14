module Api
	class Api::ProtectedResourceController < Api::BaseController
		include TokenAuthenticatableHandler

		before_filter { authenticate_user_from_token! }
	end
end