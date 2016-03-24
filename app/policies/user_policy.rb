class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def show?
    user.admin? or user.vip? or record.id == user.id
  end

  def destroy?
    user.admin? or record.id == user.id
  end
end


