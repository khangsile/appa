object @user
node(:auth_token) { @user.authentication_token }
node(:user) do |user|
	partial('api/v1/users/user_base', object: user, locals: {hide_email:false})
end