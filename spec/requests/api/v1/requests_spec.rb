require 'spec_helper'

describe 'Requests API' do
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 'X-AUTH-TOKEN' => 'fill_in' } }
	let(:trip) { FactoryGirl.create :trip }
	describe "#create" do 

		context 'when user is authenticated' do
			before { headers['X-AUTH-TOKEN'] = FactoryGirl.create(:user).authentication_token }
			context 'when trip exists' do
				it 'should create a request for that trip' do
					expect{create_request(trip)}.to change(Request, :count).by(1)
					expect(response).to be_success
					expect(json['success']).to eq(true)				
				end
			end

			context 'when trip has passed' do
				it 'should not create a request for that trip' do
					expect{create_request(FactoryGirl.create(:trip, start_time: Time.now-1.week))}.to_not change(Request, :count)
					expect(response.response_code).to eq(405)
				end
			end

			context 'when trip does not exist' do
				it 'should not create a request for that trip' do
					expect{create_request(1)}.to_not change(Request, :count)
					expect(response.response_code).to eq(404)
				end
			end
		end

		context 'when user is not authenticated' do
			it 'should not create a request for that trip' do
				expect{create_request(trip)}.to_not change(Request, :count)
				expect(response.response_code).to eq(401)		
			end
		end

	end

	describe "#update" do
		let(:request) { FactoryGirl.create :request }
		context "when user owns trip of request" do
			before { headers['X-AUTH-TOKEN'] = request.trip.owner.authentication_token }
			it "should update accepted field" do
				update_request(request,accepted: true)
				expect{request.reload}.to change(request,:accepted).to(true)
				expect(response).to be_success
			end
		end

		context "when user does not own trip of request" do
			before { headers['X-AUTH-TOKEN'] = FactoryGirl.create(:user).authentication_token }
			it "should not update accepted field" do
				update_request(request,accepted: true)
				expect{request.reload}.to_not change(request,:accepted)
				expect(response.response_code).to eq(401)
			end
		end

	end
end

def update_request(request, params)
	put api_v1_request_path(request), params, headers
end

def create_request(trip)
	post api_v1_trip_requests_path(trip), {}, headers
end


