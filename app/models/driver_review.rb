class AcceptedRequestValidator < ActiveModel::Validator
  def validate(record)
	  unless record.request.accepted?
	  	record.errors[:request] << "is not accepted"
	  end
  end
end

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

	validates :content, presence: true, length: { maximum: 140 }
	validates :request_id, presence: true, uniqueness: true
	validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
	validates :driver_id, presence: true
	validates :user_id, presence: true
	validates_with AcceptedRequestValidator, if: "!self.request_id.blank?"
	validates_with UserOwnsRequestValidator, if: "!self.request_id.blank?"

end
