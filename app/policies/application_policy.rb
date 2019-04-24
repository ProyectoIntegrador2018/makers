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
  end
end
