require 'spec_helper'

describe "User API" do

	let(:headers) { { "CONTENT_TYPE" => "application/json" } }

	before do
		@user = FactoryGirl.create(:user)
	end

	let(:user) { @user }

	subject { response }

	context "when user is valid" do
		before do
			get_user({ auth_token: user.authentication_token })
		end

		it { should respond_with_content_type(:json) }
		it { should respond_with 200 }

		it { should contain(user.first_name) }
		it "has the first name" do
			expect(response).to contain("#{user.first_name}")
		end

		it "has a 200 status code" do
			expect(response.code).to respond_with 200
		end
	end

	describe "requesting user profile with invalid auth" do
		before do
			get_user(auth_token: "notgoingtowork")			
		end

		its(:response_code) { should == 401 }
	end

	def get_user(params)
		post "/api/v1/users/"+user.id.to_s, params.to_json, {'CONTENT_TYPE' => 'application/json'}
	end

end
