# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  def landing
    @bodyClass = "Home"
    render :layout => false
  end
end
