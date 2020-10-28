class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_breadcrumb I18n.t("breadcrumbs.home"), :root_path

  protected

  def set_locale
    I18n.locale = :es || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:given_name, :last_name, :email, :institutional_id, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:given_name, :last_name, :email, :institutional_id, :password, :password_confirmation, :current_password)
    end
  end

  def user_not_authorized
    redirect_to root_path
  end
end
