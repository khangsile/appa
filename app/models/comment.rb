class Comment < ActiveRecord::Base

	belongs_to :post, dependent: :destroy
	belongs_to :user, dependent: :destroy

	validates :post_id, presence: true
	validates :user_id, presence: true
	validates :content, presence: true
		
end