class RatingPolicy <ApplicationPolicy
  attr_reader :user, :record

  def create?
    user
  end

  def update?
    user.admin? or record.user_id == user.id
  end

  def destroy?
    user.admin? or user.vip? or record.user_id == user.id
  end
end