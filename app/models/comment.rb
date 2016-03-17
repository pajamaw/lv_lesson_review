class Comment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user #:commenter class_name: 'User'
  #has_many :ratings, as: :ratable



end
