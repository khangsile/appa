
# Users can only create a review if a driver has accepted to drive him/her
# Validate that the associated request is accepted
class AcceptedRequestValidator < ActiveModel::Validator
  def validate(record)
	  unless record.request.accepted?
	  	record.errors[:request] << "is not accepted"
	  end
  end
end

# Users can only create a review associated with their own requests
# Validate that the associated user owns the associated request
class UserOwnsRequestValidator < ActiveModel::Validator
	def validate(record)
		unless record.request.user_id == record.user_id
			record.errors[:user] << "has not ridden with driver"
		end
	end
end

class DriverReview < ActiveRecord::Base

	belongs_to :request
	belongs_to :user
	belongs_to :driver

	# After the creation of a review, update corresponding driver's rating
	after_create do
		driver = Driver.find_by(id: self.driver_id)
		driver.update(rating: DriverReview.where(driver_id: driver.id).average(:rating).to_f)
	end

	validates :content, length: { maximum: 140 }
	validates :request_id, presence: true, uniqueness: true
	validates :rating, presence: true, numericality: { greater_than_or_equal: 0, less_than_or_equal_to: 5 }
	validates :driver_id, presence: true
	validates :user_id, presence: true
	# validates_with AcceptedRequestValidator, if: "!self.request_id.blank?"
	# validates_with UserOwnsRequestValidator, if: "!self.request_id.blank?"

end
