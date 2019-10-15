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
      roles - [['Superadmin', 'superadmin'], ['Lab Admin', 'lab_admin']] if user.lab_admin?
    end

    def resolve_admin
      resolve
    end
  end
end
