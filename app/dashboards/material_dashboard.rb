require "administrate/base_dashboard"

class MaterialDashboard < CapabilityMaterialDashboard
  # Overwrite this method to customize how materials are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(material)
    material.name
  end
end
