class UserReview < ActiveRecord::Base	
	belongs_to :reviewer, class_name: "Driver", foreign_key: "reviewer_id"
	belongs_to :reviewee, class_name: "User", foreign_key: "reviewee_id"

	validates :content, presence: true, length: { maximum: 140 }
	validates :reviewer_id, presence: true
	validates :reviewee_id, presence: true
end
