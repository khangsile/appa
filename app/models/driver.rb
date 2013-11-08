class Driver < ActiveRecord::Base

	# Initialize driver's fee and balance
	before_validation(on: :create) do 
		self.fee = 0.0
		self.balance = 0.0
	end

	set_rgeo_factory_for_column(:location,
		RGeo::Geographic.spherical_factory(:srid => 4326))

	belongs_to :user
	has_many :requests
	has_many :driver_reviews
	has_many :users, through: :driver_reviews
	has_many :cars

	validates :user_id, presence: true, uniqueness: true
	validates :balance, numericality: { greater_than_or_equal_to: 0 }

	scope :active, -> { where(active: true) }

	# Set the current location of driver
	def set_location(lon, lat)
		factory = Driver.rgeo_factory_for_column(:location)
		# update(location: factory.point(lon,lat))
		self.location = factory.point(lon,lat)
	end

	# Class method to find all drivers within a bounding box
	def self.within(left, bottom, right, top)
		where(%{
			Drivers.location && ST_MakeEnvelope(%f, %f, %f, %f, 4326)
			} % [left,bottom,right,top]).active
	end

	# def self.within(longitude, latitude, distance)
	# 	where(%{
	# 		ST_DWithin(
	# 			Drivers.location,
	# 			ST_GeographyFromText('SRID=4326;POINT(%f, %f)'),
	# 			%d
	# 		)
	# 		} % [longitude, latitude, distance])
	# end

end
