# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :request do
		user
		trip
		time_sent Time.now		
	end
end

FactoryGirl.define do
	factory :pending_request do
		user
		driver
	end
end
