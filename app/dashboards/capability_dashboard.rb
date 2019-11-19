require "administrate/base_dashboard"

class CapabilityDashboard < CapabilityMaterialDashboard
  # Overwrite this method to customize how capabilities are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(capability)
    capability.name
  end
end
