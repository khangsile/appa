require 'resque'
require 'gcm'

module SubmitRequest

	@queue = :submit_request

	def self.perform(request_id, args = {})
		req_info = JSON.parse(args)
		# Request.includes(:user).find_by(id: req_info[:user_id])
		# device = Device.find_by(user_id: req_info[:driver_id])

		gcm = GCM.new(ENV['gcm_key'])
		registration_id = [1]
		options = {
			'data' => {
				'message' => 'Hello world!'
			},
			'collapse_key' => 'sent_request'
		}
		response = gcm.send_notification(registration_id, options)
	end

	private



end
