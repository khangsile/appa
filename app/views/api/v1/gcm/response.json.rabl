object @request
attributes :accepted
node(:type) { 'response' }
node(:request_id) { @request.id }
child(@request.driver.user => :user) { extends('api/v1/drivers/show') }
child(:trip) do |t|
	attributes :driver_id
	node(:start) do |t|
		{ lon: t.start_location.lon, lat: t.start_location.lat}
	end
	node(:end) do |t|
		{ lon: t.end_location.lon, lat: t.end_location.lat}
	end
end
# node(:user) { partial('api/v1/drivers/show', object: @request.driver.user) }



				# 'message' => {
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