require "administrate/base_dashboard"

class AvailableHourDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    equipment: Field::BelongsTo,
    id: Field::Number,
    start_time: Field::Time,
    end_time: Field::Time,
    day_of_week: Field::String.with_options(searchable: false),
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
    :id,
    :start_time,
    :end_time,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :equipment,
    :id,
    :start_time,
    :end_time,
    :day_of_week,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :equipment,
    :start_time,
    :end_time,
    :day_of_week,
  ].freeze

  # Overwrite this method to customize how available hours are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(available_hour)
  #   "AvailableHour ##{available_hour.id}"
  # end
end
