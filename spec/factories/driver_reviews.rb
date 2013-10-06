# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver_review do
  	request
    content "Lorem ipsum"
    rating 3
  end
end
