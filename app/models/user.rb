class User < ActiveRecord::Base
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :comments #, as: :commenter
  has_many :ratings
  has_many :rated_lessons, through: :ratings
  #has_many :rated_comments, through: :ratings,
  #source: :ratable, source_type: 'Comment' #going to have ratings on comments and lessons,  
  #therefore users will also have ratings through their comments

  enum role: [:member, :vip, :admin]
  
  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.role = 2
    end
  end

    def users_only_rating?
      self.ratings.where('lesson_id != ?', params[:lesson_id])
    end

  def average
    average = 0
    total = 0
    self.ratings.each do |num|
      total += num.star_rating.to_f
      end
    average = total / self.ratings.count
  end


end       

