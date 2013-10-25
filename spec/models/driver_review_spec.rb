require 'spec_helper'

describe DriverReview do

	let(:review) { FactoryGirl.create :driver_review }

	subject { review }

	it { should respond_to(:request_id) }
	it { should respond_to(:content) }
	it { should respond_to(:rating) }

	it { should be_valid }
	its(:driver_id) { should_not be_nil }
	its(:user_id) { should_not be_nil }
	its(:user_id) { should eq(review.request.user_id)}

	context "when request is not present" do
		before { review.request_id = nil }
		it { should_not be_valid }
	end

	context "when review for request already exists" do
		it "is invalid" do
			invalid_review = FactoryGirl.build(:driver_review, request: review.request)
			expect(invalid_review).to be_invalid
		end
	end

	context "when content is not present" do
		before { review.content = "" }
		it { should_not be_valid }
	end

	context "when request is not accepted" do
		it "is not valid" do
			request = FactoryGirl.create(:request, accepted: false)
			invalid_review = FactoryGirl.build(:driver_review, request: request)
			expect(invalid_review).to_not be_valid
		end
	end

	context "when rating is negative" do
		before { review.rating = -1 }
		it { should_not be_valid }
	end

	context "when rating is greater than 5" do
		before { review.rating = 6 }
		it { should_not be_valid }
	end

	context "when party is missing" do
		it "is missing driver_id" do
			review.driver_id = nil
		end

		it "is missing user_id" do
			review.user_id = nil
		end
	end

end
