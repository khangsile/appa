class Driver < ActiveRecord::Base

belongs_to :user
has_many :requests

validates :user_id, presence: true
validates :fee, :numericality => { :greater_than => 0 }


end
