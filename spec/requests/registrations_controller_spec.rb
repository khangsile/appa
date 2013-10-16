require 'spec_helper'

describe "RegistrationsController" do

	subject{ response }

	context "#create" do
		before do
			@user = FactoryGirl.build(:user)
			user_info = { email: @user.email, first_name: @user.first_name,
				last_name: @user.last_name, password: @user.password,
				password_confirmation: @user.password_confirmation }
				create_user(user_info)
		end

		it { should be_success }
		its(:body) { should include(@user.first_name) }
	end

	context "#create_driver" do
		before do
			@user = FactoryGirl.create(:user)
			@headers = {'HTTP_ACCEPT' => 'application/json', 
				'X-AUTH-TOKEN' => @user.authentication_token }
		end

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

	def create_user(user)
		post api_v1_registrations_path, user, headers
	end

	def create_driver(params)
		post api_v1_create_driver_path, params, @headers
	end