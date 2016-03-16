class Comment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user #:commenter class_name: 'User'
  has_many :ratings, as: :ratable


  def self.owner
    @user = User.find_by(id: self.user_id)
  end
end
