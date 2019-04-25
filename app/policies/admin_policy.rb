class AdminPolicy
  attr_reader :user, :record

  def initialize(user, admin)
    @user = user
    @record = admin
  end

  def show?
    !user.user?
  end
end
