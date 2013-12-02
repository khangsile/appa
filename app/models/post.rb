class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :trip
	has_many :comments
	validates :user_id, presence: true
	validates :trip_id, presence: true
	validates :content, presence: true

end

