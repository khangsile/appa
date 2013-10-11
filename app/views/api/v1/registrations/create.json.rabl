object false
node(:auth_token) { @user.authentication_token }
child(@user) { attributes :id, :first_name, :last_name, :email }