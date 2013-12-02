require 'spec_helper'

describe 'Trips API' do
	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 'X-AUTH-TOKEN' => 'fill_in' } }

	describe "#create" do
		let(:params) { {description: 'Titleist', start_time: Time.now, min_seats: 3, cost: 30.00, tag_list: ['lolla','bon']} }
		let(:user) { FactoryGirl.create :user }

		context "when user is authenticated" do
			before { headers['X-AUTH-TOKEN'] = user.authentication_token }

			it "should create a trip" do
				expect{create_trip(params)}.to change(Trip, :count).by(1)
				expect(response).to be_success
				expect(json['description']).to eq(params[:description])
				expect(json['tag_list']).to include 'lolla'
				expect(json['tag_list']).to include 'bon'
			end

			context "when min seats is not valid" do
				it "should not create a trip with -3 seats" do
					params[:min_seats] = -3
					expect{create_trip(params)}.to_not change(Trip, :count)
					expect(response.response_code).to eq(405)
				end
			end

			context "when cost is not valid" do
				it "should not create a trip with negative cost" do  
					params[:cost] = -1.00
					expect{create_trip(params)}.to_not change(Trip, :count)
					expect(response.response_code).to eq(405)
				end
			end
		end

		context "when user is not authenticated" do
			before { create_trip(params) }

			it { expect(response.response_code).to eq(401) }
		end
	end

	describe "#update" do
		let(:params) { {cost: 15.00, min_seats: 4, tag_list: ['lolla','bon']} }
		let(:trip) { FactoryGirl.create :trip }

		context "when user is authenticated and authorized" do
			before { headers['X-AUTH-TOKEN'] = trip.owner.authentication_token }
			it "should update trip" do
				update_trip(trip,params)
				expect(json['cost']).to eq(15.00)
				expect(json['min_seats']).to eq(4)
				expect(json['tag_list']).to include 'lolla'
				expect(response).to be_success
			end

			it { expect{update_trip(trip,cost: -15.00)}.to_not change(trip,:cost) }
			it { expect{update_trip(trip,min_seats: -1)}.to_not change(trip,:min_seats) }
		end

		context "when user is not authorized" do
			before { headers['X-AUTH-TOKEN'] = FactoryGirl.create(:user).authentication_token }
			it { expect{ update_trip(trip, params) }.to_not change(trip, :cost) }
			it { expect{ update_trip(trip, params) }.to_not change(trip, :min_seats) }
		end

	end

	describe "#show" do
		let(:trip) { FactoryGirl.create :trip }

		it "should show trip" do
			show_trip(trip)
			expect(response).to be_success
			expect(json['description']).to eq(trip.description)
		end

		it "should not show false trip" do
			show_trip(100)
			expect(response.response_code).to eq(404)
		end

	end

end

def show_trip(trip)
	get api_v1_trip_path(trip), {}, headers
end

def create_trip(params)
	post api_v1_trips_path, params, headers
	# put api_v1_driver_driver_reviews_path(user), params, headers
end

def update_trip(trip, params)
	patch api_v1_trip_path(trip), params, headers
end