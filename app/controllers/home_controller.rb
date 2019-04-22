# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  def landing
    @body_class = 'Home'
    @capabilities = Capability.all
    @materials = Material.all
    render layout: false
  end
end
