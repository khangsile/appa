FactoryGirl.define do
	factory :user do
		name 'Test user'
		email 'example@example.org'
		password 'changeme'
		password_confirmation 'changeme'
	end
end