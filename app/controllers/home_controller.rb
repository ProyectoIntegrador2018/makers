# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  def landing
    @body_class = 'Home'
    render layout: false
  end
end
