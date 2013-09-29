# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :request do
		driver_id 1
		user_id 2
	end
end

FactoryGirl.define do
	factory :pending_request, class: PendingRequest do
		driver_id 1
		user_id 2
	end
end
