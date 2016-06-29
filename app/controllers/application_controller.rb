class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :profile_photo, :description, :superadmin])

  end

  def authenticate_admin_user!
      redirect_to '/' and return if user_signed_in? && !current_user.superadmin? 
      authenticate_user! 
    end 
    def current_admin_user #use predefined method name
      return nil if user_signed_in? && !current_user.superadmin? 
      current_user 
    end 
end
