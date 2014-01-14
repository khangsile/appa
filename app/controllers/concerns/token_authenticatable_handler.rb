module TokenAuthenticatableHandler
  extend ActiveSupport::Concern

  def authenticate_user_from_token!
    # Set the authentication token params if not already present,
    # see http://stackoverflow.com/questions/11017348/rails-api-authentication-by-headers-token
    user_token = request.headers["X-AUTH-TOKEN"].presence
    user_email = request.headers["X-USER-EMAIL"].presence
    # Rails.logger.info user_token
    # Rails.logger.info user_email

    # See https://github.com/ryanb/cancan/blob/1.6.10/lib/cancan/controller_resource.rb#L108-L111
    user = user_email && User.find_by(email: user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, user_token)
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

end