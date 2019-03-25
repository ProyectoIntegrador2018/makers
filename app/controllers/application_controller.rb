class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:given_name, :last_name, :email, :password)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:given_name, :last_name, :email, :password, :current_password)
    end
  end
end
