class AcceptedRequestValidator < ActiveModel::Validator
  def validate(record)
	  unless record.request.accepted?
	  	record.errors[:base] << "Request is not accepted"
	  end
  end
end

class DriverReview < ActiveRecord::Base
	
	belongs_to :request

	validates :content, presence: true, length: { maximum: 140 }
	validates :request_id, presence: true, uniqueness: true
	validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
	validates_with AcceptedRequestValidator, if: "!self.request.blank?"

end
