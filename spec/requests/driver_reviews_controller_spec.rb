require 'spec_helper'

describe "DriverReviews Controller" do
	before do
		@request = FactoryGirl.create(:request)
	end

	subject{ response }
	
	let(:headers) { {'HTTP_ACCEPT' => 'application/json'} }

	context "#create" do
		before do
			@params = {driver_review: { request_id: @request.id, content: "Lorem Ipsum",
				rating: 3}, auth_token: @request.user.authentication_token }
		end

		context "when review is valid" do
			before { create_review(@params) }

			it { should be_success }
			its(:body) { should include("Lorem Ipsum") }
		end

		context "when user has not ridden with driver" do
			before do
				@params[:driver_review][:request_id] = 100
				create_review(@params)
			end

			it { should_not be_success }
			its(:response_code) { should == 401 }
		end

		# context "when user does not own request" do
			# before do
	end

	context "#update" do
		before do
			@review = FactoryGirl.create(:driver_review)
		end

		context "when user does not own review" do
			before do
				user = FactoryGirl.create(:user)
				params = { auth_token: user.authentication_token,
					driver_review: { content: "Hello world", rating: 5} }
				update_review(@review, params)
			end

			its(:response_code) { should == 401 }
		end

		context "when user owns review" do
			before do
				params = { auth_token: @review.request.user.authentication_token,
					driver_review: { content: "Hello world", rating: 5} }
				update_review(@review, params)
			end

			it { should be_success }
			its(:body) { should include "Hello world" }
		end
	end

	context "#destroy" do
	end

	context "#show" do
	end

end

def create_review(params)
	post api_v1_driver_reviews_path, params, headers
end 

def update_review(id, params)
	put api_v1_driver_review_path(id), params, headers
end

