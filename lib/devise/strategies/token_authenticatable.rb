module Devise
	module Strategies
		class TokenAuthenticatable < Authenticatable
			# Perform token authentication if request has token header
			def valid?
				auth_token.present?
				Rails.logger.debug 'token present'
			end

			def authenticate!
				klass = mapping.to
				resource = klass.find_by(authentication_token: auth_token)
				Rails.logger.debug 'token login'
				# Rails.logger.debug auth_token
				# Rails.logger.debug resource.to_yaml
				return fail!(:not_found_in_database) if resource.nil?
				success!(resource)
			end

			private

			def auth_token
				request.headers['X-AUTH-TOKEN']
			end

		end

		Warden::Strategies.add(:token_authenticatable, Devise::Strategies::TokenAuthenticatable)
	end
end

