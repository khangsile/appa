class FbProfilePic < ActiveRecord::Base

	belongs_to :user, dependent: :destroy
	validates :user_id, presence: true
	validates :url, presence: true
		
end