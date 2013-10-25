object @user
attributes :id, :first_name, :last_name
node(:email) { |user| user.email } unless locals[:hide_email]