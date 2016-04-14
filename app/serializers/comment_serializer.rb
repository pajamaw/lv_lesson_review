class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :lesson_id, :content, :created_at, :user
end
