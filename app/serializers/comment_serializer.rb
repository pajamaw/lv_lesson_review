class CommentSerializer < ActiveModel::Serializer
  attributes :user_id, :lesson_id, :content
  belongs_to :lesson, serializer: LessonSerializer
end
