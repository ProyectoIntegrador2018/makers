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
    image: Field::String,
    created_at: Field::DateTime,
    reservations: Field::NestedHasMany,
    updated_at: Field::DateTime,
    technical_description: Field::Text,
    max_usage: Field::Number,
    rest_time: Field::Number,
    upcoming_reservations: Field::Number,
    auto_confirm: Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :lab_space,
    :upcoming_reservations,
    :created_at,
    :updated_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :description,
    :technical_description,
    :max_usage,
    :rest_time,
    :available_hours,
    :image,
    :materials,
    :capabilities,
    :reservations,
    :lab_space,
    :created_at,
    :updated_at,
    :auto_confirm
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :image,
    :name,
    :description,
    :technical_description,
    :materials,
    :capabilities,
    :lab_space,
    :max_usage,
    :rest_time,
    :available_hours,
    :auto_confirm
  ].freeze

  # Overwrite this method to customize how equipment are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(equipment)
    equipment.name
  end
end
