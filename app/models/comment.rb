class Comment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  has_many :ratings, as: :ratable
end
