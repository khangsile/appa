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
				send_pending_request(driver_id: request.driver_id)
			end

			it "creates request for ride" do
				expect(response).to be_success
				expect(response.body).to include 'driver_id'
			end
		end

		context "when request does not have driver_id" do
			before do
			  send_pending_request({})
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
				headers['X-AUTH-TOKEN'] = request.driver.user.authentication_token
			  update_pending_request(request, accepted: true)
			end

			it "completes request" do
				request.reload
				expect(response).to be_success
				expect(request.accepted).to eq(true)
			end
		end

		context "when driver does not own request" do
			before do
				bad_driver = FactoryGirl.create(:driver)
				headers['X-AUTH-TOKEN'] = bad_driver.user.authentication_token
				update_pending_request(request, accepted: true)
			end

			it "does not complete request" do
				expect(response.response_code).to eq(401)
			end
		end
	end

end

def send_pending_request(params)
	post api_v1_requests_path, params, headers
end

def update_pending_request(request, params)
	put api_v1_request_path(request), params, headers
end



