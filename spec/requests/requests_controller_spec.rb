require 'spec_helper'

describe "RequestsController" do
	let(:request) { FactoryGirl.build :pending_request }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 'X-AUTH-TOKEN' => 'fill_in'} }

	subject { response }

	describe "#index" do
		let(:user) { FactoryGirl.create :user }

		context "when user has requests" do
	
			context "when user is authorized" do
				before do
  				FactoryGirl.create_list(:request, 5, user: user)
					headers['X-AUTH-TOKEN'] = user.authentication_token
					get_requests(user)
				end

				it "gets users requests" do
					expect(response).to be_success
					body = JSON.parse(response.body)
					expect(body.length).to eq(5)
				end
			end

			context "when user is unauthorized" do
				before do
					FactoryGirl.create_list(:request, 5, user: user)
					bad_user = FactoryGirl.create :user
					headers['X-AUTH-TOKEN'] = bad_user.authentication_token
					get_requests(user)
				end

				it "does not get users requests" do
					expect(response.response_code).to eq(401)
				end
			end
		end

	end

	describe "#create" do
		let(:user) { FactoryGirl.create :user }
		let(:params) do
			{ start: {
					lat: 81,
					lon: 82
				},
				'end' => {
					lat: 82,
					lon: 84
				}
			}
		end

		context "when request is valid" do
			before do
				headers['X-AUTH-TOKEN'] = user.authentication_token
				request.driver.update(active: true)
			end

			it "creates request for ride" do
				expect{send_pending_request(request.driver, params)}.to change(Trip, :count).by(1)
				expect(response).to be_success
				expect(response.body).to include 'driver_id'
			end
		end

		context "when driver does not exist" do
			before do
			  send_pending_request(3, params)
			end

			it "does not create a request" do
				expect(response).to_not be_success
			end
		end

		context "when driver is inactive" do
			before do
				headers['X-AUTH-TOKEN'] = user.authentication_token
				send_pending_request(request.driver, params)
			end

			it "does not request for ride" do
				expect(response).to_not be_success
			end
		end

	end

	describe "#update" do
		before do
			request.submit
		end

		context "when driver answers request" do
			before do
				headers['X-AUTH-TOKEN'] = request.driver.user.authentication_token
			  update_pending_request(request.driver,request, accepted: true)
			end

			it "completes request" do
				# expect{update_pending_request(request.driver, request, accepted: true)}.to change(Trip, :count).by(1)
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

def get_requests(user)
	get api_v1_user_requests_path(user), {}, headers
end

def send_pending_request(driver, params)
	post api_v1_driver_requests_path(driver), params, headers
end

def update_pending_request(driver, request, params)
	put api_v1_driver_request_path(driver,request), params, headers
end




