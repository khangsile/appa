class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_reviews, as: :reviewer
  has_many :user_reviews, as: :reviewee

  def given_user_reviews
  	UserReview.where(reviewer: self)
  end

  def received_user_reviews
  	UserReview.where(reviewee: self)
  end
end
