require 'spec_helper'

describe "DriverControllers" do

	before do
		@driver = FactoryGirl.create(:driver)
		@user = User.find(@driver.user_id)	
	end

	let(:auth_token) { @user.authentication_token }
	let(:change_email) { "cocoa@gmail.com" } 
	let(:driver_changes) { {email: change_email, driver: { id: 2 } } }
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }


	subject { response }

	describe "#show" do

		context "when not authorized" do
			before do
				get api_v1_driver_path(500), { auth_token: auth_token }, headers
			end			
			its(:response_code) { should == 401 }
		end

		context "when not authenticated" do
			before do
				get_driver(auth_token: "notgoingtowork")			
			end

			its(:response_code) { should == 401 }
		end

		context "when authorized" do
			before do
				get_driver(auth_token: auth_token)
			end

			it { should be_success }
			its(:content_type) { should == :json }
			its(:body) { should include(@user.first_name) }
		end

	end

	describe "#update" do

		context "when not authorized" do
			pending
		end

		context "when not authenticated" do
			pending
		end

		context "when authorized" do
			before do
				edit_driver({auth_token: auth_token, user: driver_changes})
			end

			it "should edit email" do
				@user.reload
				@user.email.should == change_email
			end
			pending
		end

	end

	def get_driver(params)
		get api_v1_driver_path(@user.id), params, headers
	end

	def edit_driver(params)
		patch api_v1_driver_path(@user.id), params, headers
	end

end

