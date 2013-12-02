object @post
attributes :id, :content, :trip_id
child(:user) { attributes :id, :first_name, :last_name }