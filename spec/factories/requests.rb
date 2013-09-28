# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :request do
		driver_id 1
		user_id 1
		time_sent "2013-09-26 22:04:15"
		time_accepted "2013-09-26 22:04:15"
		confirmation_code "MyString"
	end
end

FactoryGirl.define do
	factory :pending_request, class: PendingRequest do
		driver_id 1
		user_id 2
	end
end
