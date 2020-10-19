class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    default_authorization
  end

  def show?
    default_authorization
  end

  def create?
    default_authorization
  end

  def new?
    create?
  end

  def update?
    default_authorization
  end

  def edit?
    update?
  end

  def destroy?
    default_authorization
  end

  def confirm?
    default_authorization
  end

  def reject?
    default_authorization
  end

  def default_authorization
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    def resolve_admin
      return scope.all if user.superadmin?

      alternative_admin_scope
    end

    def alternative_admin_scope
      scope.all
    end
  end
end
