object @trip
attributes :id, :description, :min_seats, :tag_list, :start_time
child(:owner) do
	extends('api/v1/users/user_base', locals: { hide_email: true })
end
child start_loc: :start_location do |t|
	extends('api/v1/locations/location')
end
child end_loc: :end_location do |t|
	extends('api/v1/locations/location')
end
node(:cost) { |t| t.cost.to_f }
node(:start_time) { |t| t.start_time.to_s }
