class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :resolve_layout
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def resolve_layout
    if user_signed_in?
      'application'
    else
      'session_layout'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:terms_of_service, :first_name, :last_name])
  end
end
