class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :ratings, each_serializer: RatingSerializer
  has_many :comments, each_serializer: CommentSerializer
end
