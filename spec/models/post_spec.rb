require 'spec_helper'

describe Post do

  it { should respond_to(:trip_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:content) }
  
end
