class AcceptedRequestValidator < ActiveModel::Validator
  def validate(record)
	  unless record.request.accepted?
	  	record.errors[:base] << "Request is not accepted"
	  end
  end
end

class DriverReview < ActiveRecord::Base

	before_validation(on: :create) do
		if self.request
			self.driver_id = self.request.driver_id
			self.user_id = self.request.user_id
		end
	end
	
	belongs_to :request
	belongs_to :user
	belongs_to :driver

	validates :content, presence: true, length: { maximum: 140 }
	validates :request_id, presence: true, uniqueness: true
	validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
	validates :driver_id, presence: true
	validates :user_id, presence: true
	validates_with AcceptedRequestValidator, if: "!self.request.blank?"

end
