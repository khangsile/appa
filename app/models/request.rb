class Request < ActiveRecord::Base

	belongs_to :user
	belongs_to :driver
	belongs_to :trip

	validates :user_id, presence: true
	validates :driver_id, presence: true

end
