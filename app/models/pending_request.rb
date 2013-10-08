# todo: abstract the storing and retrieval of pending request 

class PendingRequest < Request

	def initialize(attributes = nil)
		super(attributes)
		self.time_sent = Time.now
	end

	def finish_pending_request!(request_info={accepted: false})
		self.create_trip(request_info[:trip_info])
		request_info[:time_accepted] = Time.now
		request_info[:confirmation_code] = SecureRandom.hex(3)
		self.update_attributes!(request_info)
	end

	def self.retrieve(id)
		Request.where(id: id).first
	end

	# store pending request
	# pending request can be stored in db
	# cache provides better access and removes a trip to db
	def store
		save
	end

	private

	def create
		super
	end

	def save
		super
	end

end