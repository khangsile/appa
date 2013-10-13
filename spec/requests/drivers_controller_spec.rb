require 'spec_helper'

describe "DriverControllers" do

	before do
		@driver = FactoryGirl.create(:driver)
		@headers = {'HTTP_ACCEPT' => 'application/json', 
			'X-AUTH-TOKEN' => @driver.user.authentication_token }
	end

	let(:auth_token) { @driver.user.authentication_token }
	let(:change_email) { "cocoa@gmail.com" } 
	let(:driver_changes) { {email: change_email, driver: { id: 2 } } }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }


	subject { response }

	describe "#show" do

		context "when not authorized" do
			before do
				get api_v1_driver_path(500), {}, @headers
			end			
			
			it { should be_success }
		end

		context "when not authenticated" do
			before do
				get_driver
			end

			it { should be_success }
		end

		context "when authorized" do
			before do
				get_driver
			end

			it { should be_success }
			its(:content_type) { should == :json }
			its(:body) { should include(@driver.user.first_name) }
		end

	end


	def get_driver
		get api_v1_driver_path(@driver.user.id), {}, @headers
	end

	def edit_driver(params)
		patch api_v1_driver_path(@driver.user.id), params, @headers
	end

end

