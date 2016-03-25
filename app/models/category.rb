class Category < ActiveRecord::Base
  has_many :lessons
  has_many :comments, through: :lessons
  has_many :ratings, through: :lessons
 
  def average_rating
    if ratings.count != 0
      average = 0
      total = 0
      ratings.each do |num|
        total += num.star_rating.to_f
      end
      average = total / ratings.count
    else
      "N/A"
    end
  end

  def self.hardest_category
    all_categories = Category.all
    rated_categories = all_categories.select do |category|
      category.ratings.count != 0
    end

    rated_categories.sort{|category| category.average_rating}.first
  end
end
