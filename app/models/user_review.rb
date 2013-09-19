class UserReview < ActiveRecord::Base
	belongs_to :reviewer, class_name: "User"
	belongs_to :reviewee, class_name: "User"

	# validates :content, presence: true, length: { maximum: 140}
end
