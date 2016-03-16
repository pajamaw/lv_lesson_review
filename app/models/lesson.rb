class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  #has_many :commenters, class_name: 'User', through: :comments
  has_many :ratings, as: :ratable


end
