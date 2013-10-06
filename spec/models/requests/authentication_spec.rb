require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }

	describe "sign in page" do
		before { visit new_user_session_path }

		it { should have_content("Sign in") }

		let(:user) { FactoryGirl.create(:user) }

		describe "with invalid information" do
			before do
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password + "j"
				click_button "Sign in"
			end

			it { should have_selector("div.alert.alert-danger") }
		end

		describe "with valid information" do
			before do
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Sign in"
			end

			it { should have_link('Sign out'), destroy_user_session_path }
		end		
			
  end
end