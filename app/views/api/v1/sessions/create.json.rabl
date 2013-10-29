object false
node(:auth_token) { @user.authentication_token }
child(@user) do
	extends('api/v1/users/user_base', locals: { hide_email: false })
	child({driver: :driver_profile}, unless: @user.driver.nil?) { extends('api/v1/drivers/driver') }
end

