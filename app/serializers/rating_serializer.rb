class RatingSerializer < ActiveModel::Serializer
  attributes :user_id, :lesson_id, :star_rating
  belongs_to :lesson, serializer: LessonSerializer

end
