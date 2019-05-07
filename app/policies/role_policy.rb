class RolePolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      roles = User.roles.keys.map { |role| [role.titleize, role] }
      return roles if user.superadmin?

      roles - [%w[Superadmin superadmin]] if user.admin?
    end

    def resolve_admin
      resolve
    end
  end
end
