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
			let(:user) { FactoryGirl.create :user }

			before { headers['X-AUTH-TOKEN'] = user.authentication_token }

			it "creates a driver" do
				expect{create_driver(params)}.to change(Driver, :count).by(1)
				expect(response).to be_success
				expect(response.body).to include user.first_name
			end
		end

		context "when user has a driver profile" do
			before { headers['X-AUTH-TOKEN'] = driver.user.authentication_token }

			it "does not create a driver" do
				expect{create_driver(params)}.to_not change(Driver, :count)
				expect(response).to_not be_success
			end
		end

	end
end 

def create_driver(params)
	post api_v1_drivers_path, params, headers
end

def get_driver(driver)
	get api_v1_driver_path(driver), {}, headers
end

def update_driver(driver, params)
	patch api_v1_driver_path(driver), params, headers
end




