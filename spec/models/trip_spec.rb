require 'spec_helper'

describe Trip do

	it { should respond_to(:start_location) }
	it { should respond_to(:end_location) }
  it { should respond_to(:driver_id) }
  it { should respond_to(:start_time) }
  it { should respond_to(:cost) }
  it { should respond_to(:min_seats) }
  it { should respond_to(:owner_id) }

	it { expect(FactoryGirl.build(:trip)).to be_valid }
  it { expect(FactoryGirl.build(:trip, cost: 3.11)).to be_valid }
  it { expect(FactoryGirl.build(:trip, cost: -5.0)).to_not be_valid }
  it { expect(FactoryGirl.build(:trip, min_seats: -1)).to_not be_valid }
  it { expect(FactoryGirl.build(:trip, min_seats: 1)).to_not be_valid }
  it { expect(FactoryGirl.build(:trip, min_seats: 2)).to be_valid }
  it { expect(FactoryGirl.build(:trip, min_seats: 3)).to be_valid }

end
