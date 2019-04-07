require "administrate/base_dashboard"

class LabSpaceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    lab: Field::BelongsTo,
    equipment: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    hours: Field::String,
    location: Field::String,
    contact_email: Field::String,
    contact_phone: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    image: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :lab,
    :equipment,
    :id,
    :name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :lab,
    :equipment,
    :id,
    :name,
    :description,
    :hours,
    :location,
    :contact_email,
    :contact_phone,
    :created_at,
    :updated_at,
    :image,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :lab,
    :equipment,
    :name,
    :description,
    :hours,
    :location,
    :contact_email,
    :contact_phone,
    :image,
  ].freeze

  # Overwrite this method to customize how lab spaces are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(lab_space)
  #   "LabSpace ##{lab_space.id}"
  # end
end
