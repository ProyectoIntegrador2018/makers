require "administrate/base_dashboard"

class EquipmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    equipment_materials: Field::HasMany,
    materials: Field::HasMany,
    equipment_capabilities: Field::HasMany,
    capabilities: Field::HasMany,
    available_hours: Field::HasMany,
    reservations: Field::HasMany,
    lab_space: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    image: Field::String,
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
    :equipment_materials,
    :materials,
    :equipment_capabilities,
    :capabilities,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :equipment_materials,
    :materials,
    :equipment_capabilities,
    :capabilities,
    :available_hours,
    :reservations,
    :lab_space,
    :id,
    :name,
    :description,
    :image,
    :created_at,
    :updated_at,
    :technical_description,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :equipment_materials,
    :materials,
    :equipment_capabilities,
    :capabilities,
    :available_hours,
    :reservations,
    :lab_space,
    :name,
    :description,
    :image,
    :technical_description,
  ].freeze

  # Overwrite this method to customize how equipment are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(equipment)
  #   "Equipment ##{equipment.id}"
  # end
end
