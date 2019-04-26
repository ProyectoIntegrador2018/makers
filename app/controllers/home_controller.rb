# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  before_action :authenticate_user!, except: [:landing]
  def landing
    @body_class = 'Home'
    @capabilities = Capability.all
    @materials = Material.all
    render layout: false
  end

  def profile
  end

end
