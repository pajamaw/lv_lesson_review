class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :ratings
  #has_many :commenters, class_name: 'User', through: :comments
  #has_many :ratings, as: :ratable

  def parse_title
    #if title.match(/(\-)/)
      #title = self.title.gsub("-", "")######(/^[\w+\s+\w]*/)
    if title.match(/(\d)/) || title.match(/(-)/)
       title.gsub("-", "").match(/^\D+/)
       ##not going to change titles until i know what information i want
       ##on here
    else
      title
    end
  end

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

  def self.hardest_lesson
    all_lessons = Lesson.all
    rated_lessons = all_lessons.select do |lesson|
      lesson.ratings.count != 0
    end

    rated_lessons.sort{|lesson| lesson.average_rating}.first
  end


   
end
