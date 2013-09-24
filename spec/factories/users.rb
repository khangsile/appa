FactoryGirl.define do
	factory :user do
		first_name "Jerry"
		last_name "Seinfeld"
		email "example@example.org"
		password "changeme"
		password_confirmation "changeme"
	end
end