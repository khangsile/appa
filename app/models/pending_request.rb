# todo: abstract the storing and retrieval of pending request 

class PendingRequest < Request
	after_initialize { self.time_sent = Time.now }

	def finish_pending_request!(request_info={accepted: false})
		request_info[:time_accepted] = Time.now
		request_info[:confirmation_code] = SecureRandom.hex(3)
		self.update_attributes(request_info)
		self.create_trip!(request_info[:trip]) if request_info[:accepted]
	end

	def self.retrieve(id)
		PendingRequest.find_by!(id: id)
	end

	# store pending request
	# pending request can be stored in db
	# cache provides better access and removes a trip to db
	def store
		self.time_sent = Time.now
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