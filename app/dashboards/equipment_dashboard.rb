require "administrate/base_dashboard"

class EquipmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    materials: Field::HasMany,
    capabilities: Field::HasMany,
    available_hours: Field::NestedHasMany.with_options(skip: :equipment),
    lab_space: BelongsToWithUserField.with_options(scope_name: :managed_lab_spaces),
    name: Field::String,
    description: Field::Text,
    image: Field::Carrierwave.with_options(
      remove: true,
      ),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    technical_description: Field::Text,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :lab_space,
    :created_at,
    :updated_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :description,
    :technical_description,
    :available_hours,
    :image,
    :materials,
    :capabilities,
    :lab_space,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :materials,
    :capabilities,
    :available_hours,
    :lab_space,
    :description,
    :image,
    :technical_description,
  ].freeze

  # Overwrite this method to customize how equipment are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(equipment)
    equipment.name
  end
end
