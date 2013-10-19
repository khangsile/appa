require 'spec_helper'

describe "DriverReviews Controller" do

	let(:headers) { {'HTTP_ACCEPT' => 'application/json', 
		'X-AUTH-TOKEN' => 'fill_in' } }

	subject{ response }

	describe "#create" do

		let(:request) { FactoryGirl.create :request }
		let(:content) { "Lorem Ipsum" }
		let(:params) { {request_id: request.id, content: content, rating: 3} }

		context "when review is valid" do
			before do 
				headers['X-AUTH-TOKEN'] = request.user.authentication_token
				create_review(params)
			end

			it "creates driver review" do
				# expect{create_review(params)}.to change(DriverReview, :count).by(1)
				expect(response).to be_success
				expect(response.body).to include content
				expect(request.user.driver_reviews.length).to eq(1)
			end
		end

		context "when user has not ridden with driver" do
			before do
				user = FactoryGirl.create :user
				headers['X-AUTH-TOKEN'] = user.authentication_token
				create_review(params)
			end

			it "does not create driver review" do
				expect(response.response_code).to eq(401)
			end
		end

	end

	describe "#update" do

		let(:review) { FactoryGirl.create :driver_review }
		let(:content) { "Hello world!"}
		let(:params) { { content: content, rating: 5} }

		context "when user does not own review" do
			let(:user) { FactoryGirl.create :user }

			before do				
				headers['X-AUTH-TOKEN'] = user.authentication_token
				update_review(review, params)
			end

			it "does not update review" do
				expect(response.response_code).to eq(401)
			end
		end

		context "when user owns review" do
			before do
				headers['X-AUTH-TOKEN'] = review.request.user.authentication_token
				update_review(review, params)
			end

			it "updates review" do
				expect(response.body).to include content
				expect(response).to be_success
			end
		end

	end

	describe "#destroy" do
		let(:review) { FactoryGirl.create :driver_review }

		context "when user owns review" do
			before do
				headers['X-AUTH-TOKEN'] = review.request.user.authentication_token
			end

			it "deletes review" do
				expect { destroy_review(review) }.to change(DriverReview, :count).by(-1)
				expect(response).to be_success
			end
		end

		context "when user does not own review" do
			before do
				user = FactoryGirl.create :user
				headers['X-AUTH-TOKEN'] = user.authentication_token
			end

			it "does not delete review" do
				review # must instantiate review before deletion
				expect { destroy_review(review) }.not_to change(DriverReview, :count)
				expect(response.response_code).to eq(401)
			end
		end

	end

	describe "#show" do
		let(:review) { FactoryGirl.create :driver_review } 

		it "gets review" do
			get_review(review)
			expect(response).to be_success
			expect(response.body).to include review.content
		end

		context "when review does not exist" do
			it "does not get review" do
				get_review(10)
				expect(response.body).to include "Resource not found"
				expect(response.response_code).to eq(404)
			end
		end
	end

end

def get_review(review)
	get api_v1_driver_review_path(review), {}, headers
end

def destroy_review(review)
	delete api_v1_driver_review_path(review), {}, headers
end

def create_review(params)
	post api_v1_driver_reviews_path, params, headers
end 

def update_review(id, params)
	put api_v1_driver_review_path(id), params, headers
end

