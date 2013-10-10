require 'spec_helper'

describe "RequestsController" do
	before do
		@request = FactoryGirl.build(:pending_request)
	end

	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }
	subject { response }

	context "#create" do

		context "when request is valid" do
			before do
				send_pending_request(auth_token: @request.user.authentication_token, request: 
					{ user_id: @request.user_id, driver_id: @request.driver_id})
			end

			it { should be_success }
			its(:body) { should include('driver_id') }
		end

		context "when request does not have driver" do
			before do
			  send_pending_request(auth_token: @request.user.authentication_token, 
			  	request: { user_id: @request.user_id })
			end

			it { should_not be_success }
		end

	end

	context "#update" do
		before do
			@request.store
		end

		context "when driver owns request" do
			before do
				update_pending_request(@request.id, auth_token: @request.driver.user.authentication_token,
					request: { accepted: true })
			end
			it { should be_success }
		end

		context "when driver does not own request" do
			before do
				user = FactoryGirl.create(:user)
				update_pending_request(@request.id, auth_token: user.authentication_token,
					request: { accepted: true })
			end

			it { should_not be_success }
		end
	end
end

def send_pending_request(params)
	post api_v1_requests_path, params, headers
end

def update_pending_request(request, params)
	patch api_v1_request_path(request), params, headers
end



