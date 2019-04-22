require "administrate/base_dashboard"

class LabAdministrationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    admin: Field::BelongsTo.with_options(class_name: "User"),
    space: Field::Polymorphic.with_options(classes: [Lab, LabSpace]),
    id: Field::Number,
    admin_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :admin,
    :space,
    :id,
    :admin_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :admin,
    :space,
    :id,
    :admin_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :admin,
    :space,
    :admin_id,
  ].freeze

  # Overwrite this method to customize how lab administrations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(lab_administration)
  #   "LabAdministration ##{lab_administration.id}"
  # end
end
