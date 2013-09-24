class Driver < ActiveRecord::Base

belongs_to :user

validates :user_id, presence: true
validates :fee, :numericality => { :greater_than => 0 }

end
