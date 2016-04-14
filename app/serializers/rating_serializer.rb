class RatingSerializer < ActiveModel::Serializer
  attributes  :lesson_id, :user_id, :star_rating, :created_at, :user
end
