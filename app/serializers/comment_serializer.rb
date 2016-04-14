class CommentSerializer < ActiveModel::Serializer
  attributes :user_id, :lesson_id, :content, :created_at, :user
end
