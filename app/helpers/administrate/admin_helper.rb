module Administrate
  module AdminHelper
    def check_attribute(attribute)
      if attribute.class == BelongsToWithUserField
        attribute.set_current_user(current_user)
      end
    end
  end
end
