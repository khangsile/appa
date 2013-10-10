module TokenAuthenticatable
	extend ActiveSupport::Concern

	module ClassMethods
		def find_by_authentication_token(authentication_token=nil)
			where(authentication_token: authentication_token).first unless authentication_token
		end
	end

	def ensure_authentication_token
    self.authentication_token = generate_authentication_token if authentication_token.blank?
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
    save(validate: false)
  end

  def ensure_authentication_token!
    reset_authentication_token if authentication_token.blank?
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end