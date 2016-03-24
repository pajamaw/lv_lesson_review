class Category < ActiveRecord::Base
  has_many :lessons
  has_many :comments, through: :lessons
  has_many :ratings, through: :lessons
 
  def average_rating
    average = 0
    total = 0
    self.ratings.each do |num|
      total += num.star_rating.to_f
    end
    average = total / self.ratings.count
  end
end
