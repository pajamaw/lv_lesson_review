class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :ratings, serializer: RatingSerializer
  has_many :comments, serializer: CommentSerializer
end
