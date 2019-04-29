class RolePolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      roles = User.roles.keys.map(&:titleize)
      return roles if user.superadmin?

      roles - ['Superadmin'] if user.admin?
    end

    def resolve_admin
      resolve
    end
  end
end
