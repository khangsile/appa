# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :request do
		user
		driver
		accepted true
		time_accepted Time.now		
	end
end

FactoryGirl.define do
	factory :pending_request do
		user
		driver
	end
end
