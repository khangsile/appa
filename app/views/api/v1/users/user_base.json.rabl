object @user
attributes :id, :first_name, :last_name
node(:email) { |user| user.email } unless locals[:hide_email]
node(:profile_pic) { |user| user.fb_profile_pic.url if user.fb_profile_pic }