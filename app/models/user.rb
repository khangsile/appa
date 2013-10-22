class User < ActiveRecord::Base
  before_save do
   self.email = self.email.downcase
   self.ensure_authentication_token
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :driver
  has_many :requests
  has_many :user_reviews, as: :reviewer
  has_many :user_reviews, as: :reviewee
  has_many :driver_reviews
  has_many :drivers, through: :driver_reviews

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def given_user_reviews
  	UserReview.where(reviewer: self)
  end

  def received_user_reviews
  	UserReview.where(reviewee: self)
  end

  def ensure_authentication_token
    self.authentication_token = generate_authentication_token if authentication_token.blank?
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
    save(validate: false)
  end

  def ensure_authentication_token!
    if authentication_token.blank?
      reset_authentication_token
    end
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
