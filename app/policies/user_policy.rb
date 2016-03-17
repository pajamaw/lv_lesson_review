class UserPolicy < ApplicationPolicy

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user
        if user.deity?
          @scope.all
        else
          @scope.all.where(user_id: user.id)
        end
      end
    end
  end

  def index?
    user.deity?
  end



  def destroy?
    user.deity? or record.id == user.id
  end
end


