require 'spec_helper'

describe UserReview do
	before do
		u1 = User.create(email: "tuan@uky.edu", password: "nubster1", password_confirmation: "nubster1")
		u2 = User.create(email: "khang@gmail.com", password: "handicap", password_confirmation: "handicap")
		@review = UserReview.new(reviewer_id: u1.id, reviewee_id: u2.id, content: "Lorem Ipsum", rating: 5)
	end

	subject { @review }

	it { should respond_to(:reviewee_id) }
	it { should respond_to(:reviewer_id) }
	it { should respond_to(:content) }
	it { should respond_to(:rating) }

	it { should be_valid }

	describe "when reviewer is not present" do
		before { @review.reviewer_id = nil }
		it { should_not be_valid }
	end

	describe "when reviewee is not present" do
		before { @review.reviewee_id = nil }
		it { should_not be_valid }
	end

	describe "when content is not present" do
		before { @review.content = "" }
		it { should_not be_valid }
	end

end
