class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  #has_many :commenters, class_name: 'User', through: :comments
  has_many :ratings, as: :ratable

  def parse_title
    #if self.title.match(/(\-)/)
      #self.title = self.title.gsub("-", "")######(/^[\w+\s+\w]*/)
    if self.title.match(/(\d)/) || self.title.match(/(-)/)
       self.title.gsub("-", "").match(/^\D+/)
       ##not going to change titles until i know what information i want
       ##on here
    else
      self.title
    end
  end



   
end
