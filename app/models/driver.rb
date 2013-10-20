class Driver < ActiveRecord::Base

	before_validation(on: :create) do 
		self.fee = 0.0
		self.balance = 0.0
	end

	belongs_to :user
	has_many :requests
	has_many :driver_reviews
	has_many :users, through: :driver_reviews
	has_many :cars

	validates :user_id, presence: true
	validates :balance, numericality: { greater_than_or_equal_to: 0 }

end
