require 'spec_helper'

describe "DriverControllers" do

	before do
		@driver = FactoryGirl.create(:driver)
	end

	let(:auth_token) { @driver.user.authentication_token }
	let(:change_email) { "cocoa@gmail.com" } 
	let(:driver_changes) { {email: change_email, driver: { id: 2 } } }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }


	subject { response }

	describe "#show" do

		context "when not authorized" do
			before do
				get api_v1_driver_path(500), { auth_token: auth_token }, headers
			end			
			
			it { should be_success }
		end

		context "when not authenticated" do
			before do
				get_driver({})			
			end

			it { should be_success }
		end

		context "when authorized" do
			before do
				get_driver(auth_token: auth_token)
			end

			it { should be_success }
			its(:content_type) { should == :json }
			its(:body) { should include(@driver.user.first_name) }
		end

	end

	describe "#update" do

		context "when not authorized" do
			before do
				driver = FactoryGirl.create(:driver)
				edit_driver({auth_token: driver.user.authentication_token, user: driver_changes})
			end

				its(:response_code) { should == 401 }
				its(:body) { should include "Unauthorized access" }
		end

		context "when not authenticated" do
			before do
				edit_driver({auth_token: "", user: driver_changes})
			end

			its(:response_code) { should == 401 }
			its(:body) { should include "Unauthorized access" }
		end

		context "when authorized" do
			before do
				edit_driver({auth_token: auth_token, user: driver_changes})
			end

			it { should be_success }

			it "should edit email" do
				@driver.reload
				@driver.user.email.should == change_email
			end
		end

	end

	def get_driver(params)
		get api_v1_driver_path(@driver.user.id), params, headers
	end

	def edit_driver(params)
		patch api_v1_driver_path(@driver.user.id), params, headers
	end

end

