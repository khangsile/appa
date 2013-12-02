require 'resque'
require 'SubmitRequest'
require 'AnswerRequest'

class Request < ActiveRecord::Base

	before_validation(on: :create) do
	  self.time_sent = Time.now
	end

	after_create do
		Resque.enqueue(SubmitRequest, self.id)
	end

	belongs_to :user, dependent: :destroy
	belongs_to :trip, dependent: :destroy	

	validates :user_id, presence: true
	validates :trip_id, presence: true
	validate :trip_has_not_passed

	def answer!(options={accepted: false})
		update!(options)
		Resque.enqueue(AnswerRequest, self.id)
	end

	private

	# validation to ensure requested trip is not out of date
	def trip_has_not_passed
		if !self.trip.present? || self.trip.start_time < self.time_sent
			errors.add(:trip, 'has already passed')
		end
	end

end

