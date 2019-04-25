require 'administrate/field/polymorphic'

class PolymorphicWithUserField < Administrate::Field::Polymorphic
  attr_writer :current_user

  def scope_names
    options.fetch(:scope_names, [])
  end

  def associated_resource_grouped_options
    classes.map do |klass|
      [klass.to_s, group_options_for(klass)]
    end
  end

  def group_options_for(klass)
    candidate_resources_for(klass).map do |resource|
      [display_candidate_resource(resource), resource.to_global_id]
    end
  end

  def candidate_resources_for(klass)
    scope_name = scope_names.fetch(klass.to_s.to_sym, nil)
    return klass.none unless scope_name

    scope = @current_user.try(scope_name)
    order ? scope.order(order) : scope.all
  end
end
