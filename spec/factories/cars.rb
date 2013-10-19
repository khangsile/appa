# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :car do
  	driver
    model "Toyota Prius"
    year 2013
    num_seats 5
  end
end
