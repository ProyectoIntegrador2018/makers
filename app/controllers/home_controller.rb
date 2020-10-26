# Home controller for static views
class HomeController < ApplicationController
  include HomeHelper
  config.cache_store = :null_store
  before_action :authenticate_user!, except: [:landing, :related, :equipment_relation]

  add_breadcrumb I18n.t("breadcrumbs.profile"), :profile_path

  def landing
    @body_class = 'Home'
    @equipments = Equipment.by_popularity
    render layout: false
  end

  def profile
    @all_reservations = current_user.reservations
    @reservations = @all_reservations.rejected.future + @all_reservations.pending.future + @all_reservations.confirmed.future
  end

  def related
    type = params[:type]
    if type == 'all'
      capabilities = Capability.select(:id, :name).as_json
      materials = Material.select(:id, :name).as_json
    elsif type == 'both'
      capabilities = apply_caps_mats_query('capabilities', params[:selectedMat])
      materials = apply_caps_mats_query('materials', params[:selectedCap])
    else # capabilities or materials
      results = apply_caps_mats_query(type, params[:selectedItem])
      query = params[:query]
      if query.present?
        # Filter results by query written
        results = results.where('name ILIKE ?', "%#{query}%").as_json
      end
    end

    respond_to do |format|
      format.json do
        render json: {
          results: results,
          capabilities: capabilities,
          materials: materials
        }
      end
    end
  end
end
