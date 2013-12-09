class User < ActiveRecord::Base
  include TokenAuthenticatable

  before_save do
   self.email = self.email.downcase
   self.ensure_authentication_token
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # paperclip profile_pic
  has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  has_one :fb_profile_pic
  has_one :driver
  has_one :device
  has_many :requests
  has_many :user_reviews, as: :reviewer
  has_many :user_reviews, as: :reviewee

  has_many :posts
  has_many :comments
  has_many :trips, foreign_key: 'owner_id'

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

end
