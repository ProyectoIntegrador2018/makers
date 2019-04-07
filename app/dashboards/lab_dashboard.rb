require "administrate/base_dashboard"

class LabDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    lab_spaces: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    location: Field::String,
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
    :lab_spaces,
    :id,
    :name,
    :description,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :lab_spaces,
    :id,
    :name,
    :description,
    :location,
    :created_at,
    :updated_at,
    :image,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :lab_spaces,
    :name,
    :description,
    :location,
    :image,
  ].freeze

  # Overwrite this method to customize how labs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(lab)
  #   "Lab ##{lab.id}"
  # end
end
