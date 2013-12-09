object @user
node(:auth_token) { @user.authentication_token }
child(@user) do
	extends('api/v1/users/user_base', locals: { hide_email: false })
end

