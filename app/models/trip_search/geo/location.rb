module TripSearch
	module Geo
	  class Location
	  	attr_accessor :lon, :lat, :title

	  	def initialize(lon,lat,title)
	  		@lon = lon
	  		@lat = lat
	  		@title = title
	  	end

	  	def initialize(options={})
	  		options = options || {}
	  		@lon = options[:longitude]
	  		@lat = options[:latitude]
	  		@title = options[:title]
	  	end

	  	def invalid_point?
	  		@lon.nil? || @lat.nil?
	  	end

	  	def coord
	  		factory = Trip.rgeo_factory_for_column(:start_location)
	  		factory.point(@lon,@lat)
	  	end

	  end
	end
end