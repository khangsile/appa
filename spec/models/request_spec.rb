require 'spec_helper'

describe Request do
	before do
		@request = FactoryGirl.create(:request)
	end
	let(:time) { Time.now }

	subject { @request }

	it { should respond_to(:driver_id) }
	it { should respond_to(:user_id) }
	it { should respond_to(:time_sent) }
	it { should be_valid }

end
