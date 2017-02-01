class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :store_current_location, :unless => :devise_controller?
  after_action :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :first_name, :last_name, :street_1, :street_2, :city, :state, :zip])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :first_name, :last_name, :street_1, :street_2, :city, :state, :zip, :image])
  end


  def store_location
  # store last url as long as it isn't a /users path
  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/ || request.fullpath =~ /\/ratings/ || request.fullpath =~ /\/map_location/ || request.fullpath =~ /\/get_events/

end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

end
