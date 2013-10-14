class Driver < ActiveRecord::Base

	set_rgeo_factory_for_column(:location,
		RGeo::Geographic.spherical_factory(:srid => 4326))

	belongs_to :user
	has_many :requests
	has_many :driver_reviews

	validates :user_id, presence: true
	validates :balance, numericality: { greater_than_or_equal_to: 0 }

	def self.within(left, bottom, right, top)
		where(%{
			Drivers.location && ST_MakeEnvelope(%f, %f, %f, %f, 4326)
			} % [left,bottom,right,top])
	end

	def self.within(longtidue, latitude, distance)
		where(%{
			ST_DWithin(
				Drivers.location,
				ST_GeographyFromText('SRID=4326;POINT(%f, %f)'),
				%d
			)
			} % [longtitude, latitude, distance])
	end

end
