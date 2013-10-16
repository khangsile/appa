object false
node(:auth_token) { |m| @user.authentication_token }
child(@user) { extends('api/v1/users/user_base', locals: { hide_email: false }) }
