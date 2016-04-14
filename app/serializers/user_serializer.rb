class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :comments, each_serializer: CommentSerializer
  has_many :ratings, each_serializer: RatingSerializer
end
