module Devise
	module Strategies
		class TokenAuthenticatable < Authenticatable
			# Perform token authentication if request has token header
			def valid?
				auth_token.present?
			end

			def authenticate!
				klass = mapping.to
				resource = klass.find_by(authentication_token: auth_token)
				# Rails.logger.info resource.to_yaml
				return fail!(:not_found_in_database) unless resource
				success!(resource)
			end

			private

			def auth_token
				request.headers['X-AUTH-TOKEN']
			end

		end
	end
end

