class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :ratings
  #has_many :commenters, class_name: 'User', through: :comments
  #has_many :ratings, as: :ratable

  def parse_title
    #if self.title.match(/(\-)/)
      #self.title = self.title.gsub("-", "")######(/^[\w+\s+\w]*/)
    if title.match(/(\d)/) || title.match(/(-)/)
       title.gsub("-", "").match(/^\D+/)
       ##not going to change titles until i know what information i want
       ##on here
    else
      title
    end
  end

  def average_rating
    average = 0
    total = 0
    self.ratings.each do |num|
      total += num.star_rating.to_f
    end
    average = total / self.ratings.count
  end


   
end
