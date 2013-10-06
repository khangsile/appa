include ApiHelper

module Api
	class Api::BaseController < ApplicationController
		respond_to :json
	end
end