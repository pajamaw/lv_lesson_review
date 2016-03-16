class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :ratings, as: :ratable
end
