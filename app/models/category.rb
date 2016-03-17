class Category < ActiveRecord::Base
  has_many :lessons
  has_many :ratings, through: :lessons
 
end
