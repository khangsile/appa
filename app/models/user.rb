class User < ActiveRecord::Base
  before_save do
   self.email = self.email.downcase
   self.ensure_authentication_token
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  has_one :driver
  has_many :user_reviews, as: :reviewer
  has_many :user_reviews, as: :reviewee

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def given_user_reviews
  	UserReview.where(reviewer: self)
  end

  def received_user_reviews
  	UserReview.where(reviewee: self)
  end
end
