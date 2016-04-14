class RatingSerializer < ActiveModel::Serializer
  attributes  :id, :lesson_id, :user_id, :star_rating, :created_at, :user
end
