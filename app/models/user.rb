class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :comments #, as: :commenter
  has_many :ratings
  has_many :rated_lessons, through: :ratings
  #has_many :rated_comments, through: :ratings,
            #source: :ratable, source_type: 'Comment' #going to have ratings on comments and lessons,  
                    #therefore users will also have ratings through their comments
  enum role: [:ban, :member, :deity]
  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end       

