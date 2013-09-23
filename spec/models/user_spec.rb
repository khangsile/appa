require 'spec_helper'

describe User do
	before do
		@user.new(email: "example@uky.edu", password: "validpassword",
							password_confirmation: "validpassword")
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password) }

	it { should be_valid }

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = nil }

		it { should_not be_valid }
	end

	describe "when password is inconsistent" do
		before { @user.password_confirmation = "invalidpassword" }

		it { should_not be_valid }
	end

  describe "when email format is invalid" do
    it "should be invalid" do
	    addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |address|
        @user.email = address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do	
  	it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |address|
				@user.email = address
				expect(@user).to be_valid
			end
		end
	end

end
