class CommentPolicy <ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user.deity? or not comment.published?
  end
end
