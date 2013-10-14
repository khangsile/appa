require 'spec_helper'

describe "RegistrationsController" do
	before do
		@user = FactoryGirl.create(:user)
		@headers = {'HTTP_ACCEPT' => 'application/json', 
			'X-AUTH-TOKEN' => @user.authentication_token }
	end

	subject{ response }
	
	context "#create_driver" do
		
		context "when user does not have driver" do
			before { create_driver({}) }

			it { should be_success }
		end

		context "when user does has driver" do
			before do
				driver = FactoryGirl.create(:driver)
				@headers['X-AUTH-TOKEN'] = driver.user.authentication_token
				create_driver({})
			end

			it { should_not be_success }
		end

	end

end

def create_driver(params)
	post api_v1_create_driver_path, params, @headers
end