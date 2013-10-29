require 'resque'
require 'SubmitRequest'
# todo: abstract the storing and retrieval of pending request 

class PendingRequest < Request
	after_initialize do 
		self.time_sent = Time.now 
		# self.accepted = false
	end

	def finish_pending_request!(request_info={accepted: false})
		self.time_accepted = Time.now		
		self.confirmation_code = SecureRandom.hex(3)
		self.accepted = request_info[:accepted]
		self.create_trip!(request_info[:trip]) if self.accepted
		save!
	end

	def self.retrieve(id)
		PendingRequest.find_by(id: id)
	end

	# store pending request
	# pending request can be stored in cache
	# cache provides better access and removes a trip to db
	def submit
		if save
			submit_to_q
		else
			false
		end
	end

	private

	def submit_to_q
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