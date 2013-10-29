class Device < ActiveRecord::Base

	belongs_to :user

	validates :registration_id, presence: true
	validates_uniqueness_of :registration_id, scope: :user_id
	validates :user_ud, uniqueness: true, presence: true
	validates :platform, presence: true

end