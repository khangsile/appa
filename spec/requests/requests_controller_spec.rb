require 'spec_helper'

describe "RequestsController" do
	before do
		@request = FactoryGirl.build(:pending_request)
		@headers = {'HTTP_ACCEPT' => 'application/json', 
			'X-AUTH-TOKEN' => @request.user.authentication_token }
	end

	subject { response }

	context "#create" do

		context "when request is valid" do
			before do
				send_pending_request(driver_id: @request.driver_id)
			end

			it { should be_success }
			its(:body) { should include('driver_id') }
		end

		context "when request does not have driver" do
			before do
			  send_pending_request({})
			end

			it { should_not be_success }
		end

	end

	context "#update" do
		before do
			@request.store
			@headers['X-AUTH-TOKEN'] = @request.driver.user.authentication_token
		end

		context "when driver answers request" do
			before { update_pending_request(accepted: true) }

			it { should be_success }

		end
	end




end

def send_pending_request(params)
	post api_v1_requests_path, params, @headers
end

def update_pending_request(params)
	put api_v1_request_path(@request.id), params, @headers
end



