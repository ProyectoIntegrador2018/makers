require 'administrate/field/belongs_to'

class BelongsToWithUserField < Administrate::Field::BelongsTo
  def set_current_user(current_user)
    @current_user = current_user
  end

  protected

  def candidate_resources
    @current_user.try(options[:scope_name])
  end
end
