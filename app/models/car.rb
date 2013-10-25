class Car < ActiveRecord::Base
	belongs_to :driver

	validates :driver_id, presence: true
	validates :model, presence: true
	validates :year, presence: true
	validates :num_seats, presence: true, 
		numericality: {greater_than_or_equal_to: 0}
end
