class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  def current_ability
  	@current_ability ||= Ability.new(current_user, params)
  end

  protected

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  	end

end
