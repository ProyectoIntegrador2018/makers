class AdminPolicy
  attr_reader :user, :record

  def initialize(user, dashboard)
    @user = user
    @record = dashboard
  end

  def show?
    !user.user?
  end
end
