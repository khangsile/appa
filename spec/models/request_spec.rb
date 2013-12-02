require 'spec_helper'

describe Request do

	it { should respond_to(:trip_id) }
	it { should respond_to(:user_id) }
	it { should respond_to(:time_sent) }
	it { should respond_to(:accepted) }


	it { expect(FactoryGirl.build(:request)).to be_valid }
	it { expect(FactoryGirl.create(:request).accepted).to eq(false) }
	it { expect(FactoryGirl.build(:request, trip: nil)).to_not be_valid }
	it { expect(FactoryGirl.build(:request, user: nil)).to_not be_valid }

end
