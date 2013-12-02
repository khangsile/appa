# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip_review do
  	user
  	description 'Lorem ipsum.'
  	rating 5
  	trip    
  end
end
