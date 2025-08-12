class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # This line allows the :name attribute to be accepted during sign-up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
