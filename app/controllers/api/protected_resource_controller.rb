module Api
	class Api::ProtectedResourceController < Api::BaseController
		include ApiAccessControl
	end
end