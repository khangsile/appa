module TokenAuthenticatable
	extend ActiveSupport::Concern

	module ClassMethods
		def find_by_authentication_token(authentication_token=nil)
			find_by(authentication_token: authentication_token) unless authentication_token
		end
	end

  # Ensure the activerecord has an authentication token
  # The activerecord is not saved to the database
	def ensure_authentication_token
    self.authentication_token = generate_authentication_token if authentication_token.blank?
  end

  # Reset the authentication token and save to the database
  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
    save(validate: false)
  end

  # Ensure the activerecord has an authentication token
  # The activerecord is saved to the database
  def ensure_authentication_token!
    reset_authentication_token! if authentication_token.blank?
  end
 
  private
  
  # Generate an authentication token  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end