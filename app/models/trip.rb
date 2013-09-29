class Trip < ActiveRecord::Base
	before_create { self.start_time = Time.now }

	has_many :requests
end
