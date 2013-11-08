require 'resque'
require 'gcm'
require 'rabl'

module AnswerRequest

	@queue = :answer_request

	def self.perform(request_id, answer)

		request = Request.includes(:driver).find_by(id: request_id)
		device = Device.find_by(user_id: request.user_id)
		# logger.debug device.user.to_yaml
		gcm = GCM.new('AIzaSyAEMKlLJW7y3w63uOzsvG0vexOvMikM-R0')
		# registration_id = ['APA91bEVcebsmLGL99pzojD7-wvvd3PQ9RUVRqnGnk206PsVdFp7eEslcoFuFkN0GcgF9Xi7zZ1HRwiOg9uG42mYL29Tls4fGjYXVuqROrj7lhl66Y_VNtyc2mfAk941Ub7y7s8uXe6dwfGcc1e0lUig4xKp1w9LKA', 'APA91bHkuSf8QITleRxYAfeoNLq-ak7KG4UxgxHAYtyf20X-XS_vVGIDwOUf1Ju5Tlkq2zjGk_eftj7NjVw-qHiziCXGRACvNlB5Cj8gbZsHyGOcwRehUPoigZpLU5P9Nt7A1ykovDPB_GHh9gWHpfBzNYI0XZniBg']
		registration_id = [device.registration_id]
		options = {
			'data' => {
				'message' => Rabl::Renderer.json(request, 'api/v1/gcm/response')
				# 	'type' => 'response',
				# 	'request_id' => request.id,
				# 	'response' => request.accepted?,
				# 	# 'driver' => {
				# 	# 	'id' => request.driver.id,
				# 	# 	'first_name' => request.driver.user.first_name,
				# 	# 	'last_name' => request.driver.user.last_name
				# 	# },
				# 	'user' => Rabl::Renderer.json(request.driver.user, 'api/v1/drivers/show'),
				# 	'message' => "#{request.driver.user.first_name} has answered."
				# }
			},
			'collapse_key' => 'update_sent'
		}
		response = gcm.send_notification(registration_id, options)
	end

end
