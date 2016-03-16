class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable, polymorphic: true



  def self.average(array)
    average = 0
    total = 0
    array.each do |num|
      total += num.star_rating.to_f
      end
      average = total / array.count
    end
end
