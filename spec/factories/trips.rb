# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
  	description 'Lolla'
    cost 3.00
    min_seats 3
    start_time Time.now + 10.week
    association :driver, factory: :user
    association :owner, factory: :user
    start_title 'start'
    end_title 'end'

    before(:create) do |trip|
    	trip.set_start(30,30)
    	trip.set_end(30,35)
    end
  end
end
