object false
node(:auth_token) { |m| @user.authentication_token }
child(@user) { attributes :id, :first_name, :last_name, :email }
