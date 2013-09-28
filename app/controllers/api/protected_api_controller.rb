include ApiHelper

module Api
	class Api::ProtectedApiController < Api::BaseController
		before_filter { authenticate_user_from_token! }
	end
end