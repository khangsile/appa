collection @drivers
attributes :id, :fee
node(:lon) { |d| d.location.lon }
node(:lat) { |d| d.location.lat }
child(:user) do
	extends('api/v1/users/user_base', locals: {hide_email: true})
end