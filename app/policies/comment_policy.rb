class CommentPolicy <ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user.deity? or user.member?
  end

  def update?
    user.deity? or record.user_id == user.id
  end

  def destroy?
    user.deity? or record.user_id == user.id
  end
end
