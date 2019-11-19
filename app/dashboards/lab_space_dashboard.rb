require "administrate/base_dashboard"
require "administrate/field/carrierwave"

class LabSpaceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    lab: BelongsToWithUserField.with_options(scope_name: :managed_labs),
    equipment: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    hours: Field::String,
    location: Field::String,
    user: Field::BelongsTo,
    contact_email: Field::String,
    contact_phone: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    image: Field::Carrierwave.with_options(
      remove: true,
    ),
    user: Field::BelongsTo.with_options(scope_name: :users)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :lab,
    :location,
    :hours,
    :contact_email,
    :user,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :description,
    :hours,
    :location,
    :lab,
    :contact_email,
    :contact_phone,
    :equipment,
    :created_at,
    :updated_at,
    :image,
    :user,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :description,
    :hours,
    :location,
    :contact_email,
    :contact_phone,
    :image,
    :lab,
    :user
  ].freeze

  # Overwrite this method to customize how lab spaces are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(lab_space)
    lab_space.name
  end
end
