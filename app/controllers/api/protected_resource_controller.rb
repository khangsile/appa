module Api
	class Api::ProtectedResourceController < Api::BaseController
		include AccessControl
	end
end