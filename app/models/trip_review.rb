class TripReview < ActiveRecord::Base

	belongs_to :user
	belongs_to :trip

	validates :rating, presence: true
	validates_uniqueness_of :trip_id, scope: :user_id
	validates :user_id, presence: true
	validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

end