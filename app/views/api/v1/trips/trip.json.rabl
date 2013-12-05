object @trip
attributes :id, :description, :date, :min_seats, :driver_id, :owner_id
node(:cost) { |t| t.cost.to_f }
node(:tag_list) { |t| t.tag_list }
