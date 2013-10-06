class Driver < ActiveRecord::Base

belongs_to :user
has_many :requests
has_many :driver_reviews

validates :user_id, presence: true
validates :balance, numericality: { greater_than_or_equal_to: 0 }


end
