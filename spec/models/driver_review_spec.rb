require 'spec_helper'

describe DriverReview do
	before do
		@review = FactoryGirl.create(:driver_review)
	end

	subject { @review }

	it { should respond_to(:request_id) }
	it { should respond_to(:content) }
	it { should respond_to(:rating) }

	it { should be_valid }

	context "when request is not present" do
		before { @review.request_id = nil }
		it { should_not be_valid }
	end

	context "when review for request already exists" do
		before do
			@review = FactoryGirl.build(:driver_review, request: @review.request)
		end

		it { should_not be_valid }
	end

	context "when content is not present" do
		before { @review.content = "" }
		it { should_not be_valid }
	end

	context "when request is not accepted" do
		before do
			request = FactoryGirl.create(:request, accepted: false)
			@review = FactoryGirl.build(:driver_review, request: request)
		end

		it { should_not be_valid }
	end

	context "when rating is negative" do
		before { @review.rating = -1 }
		it { should_not be_valid }
	end

	context "when rating is greater than 5" do
		before { @review.rating = 6 }
		it { should_not be_valid }
	end

end
