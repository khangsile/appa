class Trip < ActiveRecord::Base
	set_rgeo_factory_for_column(:start_location,
    RGeo::Geographic.spherical_factory(:srid => 4326))	

	set_rgeo_factory_for_column(:end_location,
    RGeo::Geographic.spherical_factory(:srid => 4326))	

	has_many :posts
	has_many :requests
	has_many :users, through: :requests
	has_many :trip_reviews
	belongs_to :driver, class_name: 'User', foreign_key: 'driver_id'
	belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

	# tagging
	acts_as_taggable

	validates :start_location, presence: true
	validates :end_location, presence: true
	validates :min_seats, numericality: { greater_than_or_equal_to: 2 }
	validates :cost, numericality: { greater_than_or_equal_to: 0 }

	# Need to fix
	def accepted_users
		Request.where(trip_id: self.id, accepted: true)
	end

	def includes?(user)
		!(Request.find_by(user_id: user.id, trip_id: self.id, accepted: true)).nil?
	end

	# Set the end location of trip
	def set_start(lon, lat)
		factory = Trip.rgeo_factory_for_column(:start_location)
		self.start_location = factory.point(lon,lat)
	end

	# Set the start location of trip
	def set_end(lon, lat)
		factory = Trip.rgeo_factory_for_column(:end_location)
		self.end_location = factory.point(lon,lat)
	end

	def self.starts_within(longitude, latitude, distance=50000)
		where(within_query(:start_location,longitude,latitude,distance)) 
	end

	def self.ends_within(longitude, latitude, distance=50000)
		where(within_query(:end_location,longitude,latitude,distance))
	end

	private

	def self.within_query(column, longitude, latitude, distance)
		%{
			ST_DWithin(
				Trips.%s,
				ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
				%f)
			} % [column.to_s, longitude, latitude, distance] unless longitude.blank? || latitude.blank?
	end
end
