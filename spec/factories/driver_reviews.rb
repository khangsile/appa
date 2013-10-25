# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver_review do
    content "Lorem ipsum"
    rating 3
    request
    before(:create) do |driver_review|
    	driver_review.user_id = driver_review.request.user_id
    	driver_review.driver_id = driver_review.request.driver_id    	
    end
  end
end
