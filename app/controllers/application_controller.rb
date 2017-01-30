class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :first_name, :last_name, :street_1, :street_2, :city, :state, :zip])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :first_name, :last_name, :street_1, :street_2, :city, :state, :zip, :image])
  end

end
