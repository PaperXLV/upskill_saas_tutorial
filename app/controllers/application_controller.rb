class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
    #if user submits form from devise_controller, we need to make sure the user isn't injecting into the form
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) } 
    end
end
