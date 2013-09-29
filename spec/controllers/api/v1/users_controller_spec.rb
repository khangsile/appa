require 'spec_helper'

describe Api::V1::UsersController do

	let(:headers) { { "CONTENT_TYPE" => "application/json" } }

	before do
		@user = FactoryGirl.create(:user)
	end

	subject { response }

	describe "requesting user profile with valid auth" do
		before do
			post '/api/v1/users/' + @user.id.to_s + ".json", 
				{ auth_token: @user.authentication_token }, headers
		end

		it "should have first name" do
			expect(response).to have_content("#{@user.first_name}")
		end
	end

	describe "requesting user profile with invalid auth" do
		before do
			post '/api/v1/users/' + @users.id.to_s + ".json",
				{ auth_token: "notvaluable" }, headers
		end

		its(:response_code) { should == 401 }
	end

end
