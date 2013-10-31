require 'resque'
require 'gcm'

module SubmitRequest

	@queue = :submit_request

	def self.perform(request_id, args = {})
		req_info = JSON.parse(args)
		# Request.includes(:user).find_by(id: req_info[:user_id])
		# device = Device.find_by(user_id: req_info[:driver_id])

		gcm = GCM.new('AIzaSyAEMKlLJW7y3w63uOzsvG0vexOvMikM-R0')
		# registration_id = ['APA91bEVcebsmLGL99pzojD7-wvvd3PQ9RUVRqnGnk206PsVdFp7eEslcoFuFkN0GcgF9Xi7zZ1HRwiOg9uG42mYL29Tls4fGjYXVuqROrj7lhl66Y_VNtyc2mfAk941Ub7y7s8uXe6dwfGcc1e0lUig4xKp1w9LKA']
		registration_id = [device.registration_id]
		options = {
			'data' => {
				'message' => 'Hello world!'
			},
			'collapse_key' => 'update_sent'
		}
		response = gcm.send_notification(registration_id, options)
	end

	private



end
