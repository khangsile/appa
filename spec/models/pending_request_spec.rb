require 'spec_helper'

describe PendingRequest do
	before do
		@time_sent = Time.now
		@pending_request = PendingRequest.new(driver_id: 1, user_id: 2)
	end

	subject { @pending_request }

	describe "time sent is current" do
		its(:time_sent) { should > @time_sent }
	end

	context "finishing" do
		before do
			@finished_request = PendingRequest.finish_pending_request(@pending_request,
				{accepted: true})
		end

		subject { @finished_request }

		describe "time sent is before time accepted" do
			its(:time_sent) { should < @finished_request.time_accepted }
		end

		describe "corresponding trip is created" do
			its(:trip_id) { should_not be_nil }
		end
	end

end

