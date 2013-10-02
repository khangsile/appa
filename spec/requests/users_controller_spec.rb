require 'spec_helper'

describe "User API" do

	before do
		@user = FactoryGirl.create(:user)
	end

	let(:user) { @user }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }
	subject { response }

	context "when user is valid" do
		before do
			get_user(auth_token: user.authentication_token)
		end

		it { should be_success }
		its(:content_type) { should == :json }
		its(:body) { should include(@user.first_name) }

	end

	context "when user is invalid" do
		before do
			get_user(auth_token: "notgoingtowork")			
		end

		its(:response_code) { should == 401 }
	end

	context "when user edits invalid fields" do
		before do
			edit_user(auth_token: user.authentication_token, user: { id: 5 })
		end
		pending
	end

	def get_user(params)
		get api_v1_user_path(user), params, headers
	end

	def edit_user(params)
		put api_v1_user_path(user), params.as_json, headers
	end
end
