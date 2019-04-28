require 'administrate/field/belongs_to'

class BelongsToWithUserField < Administrate::Field::BelongsTo
  attr_writer :current_user

  protected

  def candidate_resources
    # If this method fails, check if you're calling `render_field attribute`
    # if you are, make sure to call `check_attribute(attribute)` right before `render_field`
    @current_user.try(options[:scope_name])
  end
end
