require 'spec_helper'

describe "ApiAuthentication" do
	before do
		@user = FactoryGirl.build(:user)
	end

	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }
	subject { response }

	context "account creation" do
		before do
		 user_info = { user: { email: @user.email, first_name: @user.first_name,
		   last_name: @user.last_name, password: @user.password,
		   password_confirmation: @user.password_confirmation } }
		 create_user(user_info)
		end

		it { should be_success }
		its(:body) { should include(@user.first_name) }
	end
end

def create_user(user)
	post api_v1_registrations_path, user, headers
end