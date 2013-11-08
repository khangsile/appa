require 'spec_helper'

describe "DriversController" do

	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 
		'X-AUTH-TOKEN' => 'fill_in' } }
		let(:driver) { FactoryGirl.create :driver }

		subject { response }

		describe "#show" do

			context "when driver does not exist" do
				before { get_driver(1) }

				it "does not get driver" do
					expect(response.body).to include "Resource not found"
					expect(response.response_code).to eq(404)
				end			
			end

			context "when driver exists" do
				before { get_driver(driver) }

				it "gets driver" do
					expect(response).to be_success
					expect(response.body).to include driver.user.first_name
				end
			end
		end

		describe "#update" do
			let(:params) { { id: 10, fee: 10 } }

			context "when authorized driver" do
				before do
					headers['X-AUTH-TOKEN'] = driver.user.authentication_token
					update_driver(driver, params)
				end

				it "updates driver" do
					expect(response).to be_success
					expect(response.body).to include "#{params[:fee]}"
				# expect(response.body).to include "id: #{driver.id}"
			end
		end

		context "when unauthorized driver" do
			before do
				temp_driver = FactoryGirl.create :driver
				headers['X-AUTH-TOKEN'] = temp_driver.user.authentication_token
				update_driver(driver, params)
			end

			it "does not update driver" do
				expect(response.body).to include "Unauthorized"
				expect(response.response_code).to eq(401)
				driver.reload
				expect(driver.fee).to_not eq(params[:fee])
			end
		end
	end

	describe "#create" do
		let(:params) { {} }

		context "when user does not have driver profile" do
			let(:user) { FactoryGirl.create(:user, email: 'nubster@gmail.com') }

			before { headers['X-AUTH-TOKEN'] = user.authentication_token }

			it "creates a driver" do
				expect{create_driver(params)}.to change(Driver, :count).by(1)
				expect(response).to be_success
				# expect(response.body).to include user.first_name
			end
		end

		context "when user has a driver profile" do
			before { headers['X-AUTH-TOKEN'] = driver.user.authentication_token }

			it "does not create a driver" do
				expect{create_driver(params)}.to_not change(Driver, :count)
				expect(response).to_not be_success
				expect(response.body).to include "already exists"
			end
		end

	end

	describe "#update_location" do

		context "when valid driver updates location" do
			before do
				headers['X-AUTH-TOKEN'] = driver.user.authentication_token
				update_location(driver, lon: -80.3, lat: 88.1)
			end

			it { should be_success }
			its(:body) { should include '-80.3 88.1' }
		end
	end

	describe "#index" do

		before do
			drivers = FactoryGirl.create_list :driver, 5, active: true
			drivers.each do |d|
				d.set_location(80,80)
				d.save
			end
			get_drivers(params)
		end

		context "when drivers are within screen" do
			let(:params) { {left:75,bottom:75,top:85,right:85} }

			it "gets list of drivers" do
				expect(response).to be_success
				body = JSON.parse(response.body)
				expect(body.length).to eq(5)
			end
		end

		context "when drivers are not within screen" do
			let(:params) { {left:82,bottom:82,top:85,right:85} }
			it "does not get drivers that are outside of bb" do
				expect(response).to be_success
				body = JSON.parse(response.body)
				expect(body.length).to eq(0)
			end
		end

	end

end 

def get_drivers(params)
	get api_v1_drivers_path, params, headers
end

def get_driver(driver)
	get api_v1_driver_path(driver), {}, headers
end

def update_location(driver, params)
	patch api_v1_driver_driver_location_path(driver), params, headers
end

def update_driver(driver, params)
	patch api_v1_driver_path(driver), params, headers
end

def create_driver(params)
	post api_v1_drivers_path, params, headers
end





