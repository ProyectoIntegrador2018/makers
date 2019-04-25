require 'administrate/field/belongs_to'

class BelongsToWithUserField < Administrate::Field::BelongsTo
  attr_writer :current_user

  protected

  def candidate_resources
    @current_user.try(options[:scope_name])
  end
end
