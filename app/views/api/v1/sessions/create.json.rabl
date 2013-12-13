object @user
attributes authentication_token: :auth_token
child(@user) do
	extends('api/v1/users/user_base', locals: { hide_email: false })
end

