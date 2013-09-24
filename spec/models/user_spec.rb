require 'spec_helper'

describe User do
	before do
		@user = FactoryGirl.build(:user)
		# @user = User.new(first_name: "Jerry", last_name: "Seinfeld",
		# 								email: "jerry@gmail.com", password: "tonyle123",
		# 								password_confirmation: "tonyle123")
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

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

	#TODO - move to controller later
	describe "when user has posted review" do
		its(:given_user_reviews) { should_not be_empty }
	end

	describe "when user has not posted review" do
		its(:given_user_reviews) { should be_empty }
	end
end
