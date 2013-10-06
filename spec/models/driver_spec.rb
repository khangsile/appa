require 'spec_helper'

describe Driver do
  before do
    @driver = FactoryGirl.create(:driver)
  end

  subject { @driver }

  it { should respond_to(:user_id) }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @driver.user_id = nil }
		it { should_not be_valid }
  end
  
end
