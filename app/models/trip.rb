class Trip < ActiveRecord::Base
	before_save { self.start_time = Time.now }
	
	has_many :requests
end
