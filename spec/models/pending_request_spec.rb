require 'spec_helper'

describe PendingRequest do
	before do
		@time_sent = Time.now
		# @pending_request = PendingRequest.new(driver_id: 1, user_id: 2)
		@pending_request = FactoryGirl.build(:pending_request)
		@pending_request.submit
	end

	subject { @pending_request }

	describe "time sent is current" do
		its(:time_sent) { should > @time_sent }
	end

	context "when driver_id is not present" do
		it "should not be valid with blank driver" do
			@pending_request.driver_id = ""
			# @pending_request.should_not be_valid
			expect(@pending_request).to_not be_valid
		end

		it "has no driver_id" do
			@pending_request.driver_id = nil
			# @pending_request.should_not be_valid
			expect(@pending_request).to_not be_valid
		end
	end

	context "when finishing" do
		before do
			@pending_request.finish_pending_request!(accepted: true)
		end

		describe "time sent is before time accepted" do
			its(:time_sent) { should < @pending_request.time_accepted }
		end

		describe "corresponding trip is created" do
			its(:trip_id) { should_not be_nil }
		end

		it "creates a trip with latlon" do
			pending			
			# expect(@pending_request.trip.latlon).to_not be_nil
		end


	end

end

