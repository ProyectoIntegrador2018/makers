class RolePolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      User.roles.keys if user.superadmin?
      User.roles.keys - ['superadmin'] if user.admin?
    end
  end
end
