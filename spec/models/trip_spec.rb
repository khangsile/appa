require 'spec_helper'

describe Trip do

	it { should respond_to(:start_location) }
	it { should respond_to(:end_location) }
  it { should respond_to(:driver_id) }
  it { should respond_to(:start_time) }

end
