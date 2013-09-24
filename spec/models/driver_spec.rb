require 'spec_helper'

describe Driver do
  before do
  	u2 = User.create(id: 1, email: "khang@gmail.com", password: "handicap", password_confirmation: "handicap")
  	@driver = Driver.new(user_id: u2.id, fee: 20.25)
  end

  subject { @driver }

  it { should respond_to(:user_id) }
  it { should respond_to(:fee) }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @driver.user_id = nil }
		it { should_not be_valid }
  end

  describe "when fee is less than zero" do
  	before { @driver.fee = -1.0 }
  	it { should_not be_valid }
  end
end
