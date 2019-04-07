require "administrate/base_dashboard"

class ReservationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    equipment: Field::BelongsTo,
    user: Field::BelongsTo,
    id: Field::Number,
    status: Field::String.with_options(searchable: false),
    purpose: Field::String.with_options(searchable: false),
    comment: Field::Text,
    start_time: Field::DateTime,
    end_time: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :equipment,
    :user,
    :id,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :equipment,
    :user,
    :id,
    :status,
    :purpose,
    :comment,
    :start_time,
    :end_time,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :equipment,
    :user,
    :status,
    :purpose,
    :comment,
    :start_time,
    :end_time,
  ].freeze

  # Overwrite this method to customize how reservations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(reservation)
  #   "Reservation ##{reservation.id}"
  # end
end
