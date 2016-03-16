class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.deity?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end


end