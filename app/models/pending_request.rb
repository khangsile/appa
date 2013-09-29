# todo: abstract the storing and retrieval of pending request 

class PendingRequest < Request

	def initialize(attributes = nil)
		super(attributes)
		self.time_sent = Time.now
		store
	end

	def self.finish_pending_request(id, request_info={accepted: false}, trip_info=nil)
		request =	retrieve(id)
		request.create_trip(trip_info)
		request_info[:time_accepted] = Time.now
		request.update_attributes!(request_info)

		return request
	end

	def self.retrieve(id)
		Request.find(id)
	end

	private

	# store pending request
	# pending request can be stored in db
	# cache provides better access and removes a trip to db
	def store
		save
	end

	def create
		super
	end

	def save
		super
	end

end