collection @results
attributes :id, :description, :date, :min_seats, :driver_id, :owner_id
child start_loc: :start_location do |t|
	extends('api/v1/locations/location')

end
child end_loc: :end_location do |t|
	extends('api/v1/locations/location')
end
node(:cost) { |t| t.cost.to_f }
