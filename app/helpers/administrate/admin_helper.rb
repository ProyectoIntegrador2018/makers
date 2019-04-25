module Administrate
  module AdminHelper
    def check_attribute(attribute)
      attribute.current_user = current_user if [BelongsToWithUserField, PolymorphicWithUserField].include?(attribute.class)
    end
  end
end
