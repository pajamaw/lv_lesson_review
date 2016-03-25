class User < ActiveRecord::Base
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  #has_many :rated_lessons, through: :ratings
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

end       

