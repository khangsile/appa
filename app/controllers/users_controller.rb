class UsersController < ApplicationController
	before_filter { authenticate_user! }

	def edit
		@user = User.find(params[:id])
	end

	def update

	end

end