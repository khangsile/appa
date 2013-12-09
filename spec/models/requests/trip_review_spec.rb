require 'spec_helper'

describe TripReview do

	it { should respond_to(:user_id) }
	it { should respond_to(:description) }
	it { should respond_to(:rating) }
	it { should respond_to(:trip_id) }

	# Factory build is valid
	it { expect(FactoryGirl.build(:trip_review)).to be_valid }

	it { expect(FactoryGirl.build(:trip_review, rating: 0)).to be_invalid }

	# User cannot review same trip more than once
	it "is unique with respect to a user" do
		review = FactoryGirl.create :trip_review
		expect(FactoryGirl.build(:trip_review, trip: review.trip)).to_not be_valid
	end

end