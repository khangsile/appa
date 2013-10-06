include ApiHelper

module Api
	class Api::ProtectedResourceController < Api::BaseController
		before_filter { @user = authenticate_user_from_token! }
	end
end