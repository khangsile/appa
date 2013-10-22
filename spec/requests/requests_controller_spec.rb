require 'spec_helper'

describe "RequestsController" do

	let(:request) { FactoryGirl.build :pending_request }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 'X-AUTH-TOKEN' => 'fill_in'} }

	subject { response }

	describe "#create" do
		let(:user) { FactoryGirl.create :user }

		context "when request is valid" do
			before do
				headers['X-AUTH-TOKEN'] = user.authentication_token
				send_pending_request(request.driver)
			end

			it "creates request for ride" do
				expect(response).to be_success
				expect(response.body).to include 'driver_id'
			end
		end

		context "when driver does not exist" do
			before do
			  send_pending_request(3)
			end

			it "does not create a request" do
				expect(response).to_not be_success
			end
		end

	end

	describe "#update" do
		before do
			request.store
		end

		context "when driver answers request" do
			before do
				request.store
				headers['X-AUTH-TOKEN'] = request.driver.user.authentication_token
			  update_pending_request(request.driver,request, accepted: true)
			end

			it "completes request" do
				request.reload
				expect(response).to be_success
				expect(response.body).to include "true"
				expect(request.accepted).to eq(true)
			end
		end

		context "when driver does not own request" do
			before do
				bad_driver = FactoryGirl.create(:driver)
				headers['X-AUTH-TOKEN'] = bad_driver.user.authentication_token
				update_pending_request(request.driver,request, accepted: true)
			end

			it "does not complete request" do
				expect(response.response_code).to eq(401)
			end
		end
	end

end

def send_pending_request(driver)
	post api_v1_driver_requests_path(driver), {}, headers
end

def update_pending_request(driver, request, params)
	put api_v1_driver_request_path(driver,request), params, headers
end



