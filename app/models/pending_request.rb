require 'resque'
require 'SubmitRequest'
require 'AnswerRequest'
# todo: abstract the storing and retrieval of pending request 

class PendingRequest < Request
	after_initialize do 
		self.time_sent = Time.now 
	end

	# Finish a pending request with given response argument
	# Once a pending request is complete, place an answer_request job on Resque queue
	def finish_pending_request!(request_info={accepted: false})
		self.time_accepted = Time.now
		self.confirmation_code = SecureRandom.hex(3)
		self.accepted = request_info[:accepted]
		if save
			answer_request
		else
			false
		end
	end

	def self.retrieve(id)
		PendingRequest.find_by(id: id)
	end

	# store pending request
	# pending request can be stored in cache
	# cache provides better access and removes a trip to db
	def submit
		if save
			submit_request
			true
		else
			false
		end
	end

	private

	def answer_request
		Resque.enqueue(AnswerRequest, self.id, self.accepted?)
	end

	def submit_request
		Resque.enqueue(SubmitRequest, self.id, self.to_json(only: [:user_id, :driver_id]))
	end

	def save
		super
	end

	def create
		super
	end

	def redis_key(id)
		"pending_requests:#{id}"
	end

end