module Administrate
  module AdminHelper
    def check_attribute(attribute)
      attribute.set_current_user(current_user) if attribute.class == BelongsToWithUserField || attribute.class == PolymorphicWithUserField
    end
  end
end
