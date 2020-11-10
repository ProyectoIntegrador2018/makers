# Home controller for static views
class HomeController < ApplicationController
  include HomeHelper
  config.cache_store = :null_store
  before_action :authenticate_user!, only: [:profile]

  add_breadcrumb I18n.t("breadcrumbs.profile"), :profile_path

  def landing
    @body_class = 'Home'
    @equipments = Equipment.by_popularity
    render layout: false
  end

  def profile
    @reservations = current_user.reservations.where.not(status: :cancelled)
  end
end
