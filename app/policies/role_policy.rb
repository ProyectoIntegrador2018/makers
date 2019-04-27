class RolePolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      roles = User.roles.keys.map(&:titleize)
      roles if user.superadmin?
      roles - ['Superadmin'] if user.admin?
    end
  end
end
