object @request
node(:type) { 'request' }
node(:request_id) { |r| r.id }
child(:user) { extends('api/v1/users/user_base', locals: {hide_email: true}) }
child(:trip) do |t|
	attributes :driver_id
	node(:start) do |t|
		{ lon: t.start_location.lon, lat: t.start_location.lat}
	end
	node(:end) do |t|
		{ lon: t.end_location.lon, lat: t.end_location.lat}
	end
end
