require "administrate/field/polymorphic"

class PolymorphicWithUserField < Administrate::Field::Polymorphic
  def set_current_user(current_user)
    @current_user = current_user
  end

  def scope_names
    options.fetch(:scope_names, [])
  end

  def associated_resource_grouped_options
    classes.map do |klass|
      [klass.to_s, candidate_resources_for(klass).map do |resource|
        [display_candidate_resource(resource), resource.to_global_id]
      end]
    end
  end

  def candidate_resources_for(klass)
    scope_name = scope_names.fetch(klass.to_s.to_sym, nil)
    return klass.none unless scope_name

    order ? @current_user.try(scope_name).order(order) : @current_user.try(scope_name).all
  end
end
