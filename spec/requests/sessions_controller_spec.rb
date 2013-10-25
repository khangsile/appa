require 'spec_helper'

describe "SessionsController" do

	let(:user) { FactoryGirl.create :user }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 
		'X-AUTH-TOKEN' => 'fill_in' } }

	describe "#create" do

		context "when user login is valid" do
			before do
				params = { email: user.email, password: user.password }
				create_session(params)
			end

			it "logs in" do
				expect(response).to be_success
				expect(response.body).to include user.authentication_token
			end
		end

		context "when user login is invalid" do
			before do
				params = { email: user.email, password: user.password*2 }
				create_session(params)
			end

			it "does not log in" do
				expect(response.response_code).to eq(401)
				expect(response.body).to include "Error with your login or password"
			end
		end

	end

	describe "#destroy" do

		context "when user's auth token is valid" do
			before do
				headers['X-AUTH-TOKEN'] = user.authentication_token
				destroy_session
			end

			it "logs out" do				
				expect(response).to be_success
				expect(response.body).to include "true"
				expect{user.reload}.to change(user, :authentication_token)
			end
		end

		context "when user's auth token is invalid" do
			before do
				headers['X-AUTH-TOKEN'] = user.authentication_token.downcase
				destroy_session
			end

			it "does not log out" do
				expect(response.response_code).to eq(401)
				expect(response.body).to include "Unauthorized access"
			end
		end
	end

end

def create_session(params)
	post api_v1_sessions_path, params, headers
end

def destroy_session
	delete api_v1_session_path(1), {}, headers
end


