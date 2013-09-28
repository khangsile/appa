# require 'spec_helper'

describe "ApiAuthentication" do
	before do
		@user = FactoryGirl.build(:user)
	end

	subject { page }

	context "account creation" do
		it "with valid user fields" do
			post api_v1_sessions_path, [user_login: @user.as_json], content_type: :as_json
			page.should have_content(:auth_token)
		end
	end
end