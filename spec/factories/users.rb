FactoryGirl.define do
	factory :user do
		sequence(:first_name) { |n| "person#{n}" }
		sequence(:last_name) { |n| "person#{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "changeme"
		password_confirmation "changeme"
	end
end

FactoryGirl.define do
	factory :driver do
		user
		balance 100
	end
end