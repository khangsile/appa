module TripSearch
	module Geo
	  class Location
	  	attr_accessor :lon, :lat, :title, :coord

	  	def initialize(lon,lat,title)
	  		@lon = lon.to_f
	  		@lat = lat.to_f
	  		@title = title
	  	end

	  	def initialize(options={})
	  		options ||= {}
	  		# Rails.logger.info options

	  		if options.include?(:coord)
	  			@coord = options[:coord]
	  			@lat = @coord.lat if @coord
	  			@lon = @coord.lon if @coord
	  		elsif options.include?(:latitude) && options.include?(:longitude)
	  			@lon = options[:longitude].to_f
	  			@lat = options[:latitude].to_f
	  		end
	  		@title = options[:title]
	  	end

	  	def invalid_point?
	  		!valid?
	  	end

	  	def valid?
	  		@lon && @lat && within_bounds?
	  	end

	  	def coord
	  		factory = Trip.rgeo_factory_for_column(:start_location)
	  		if factory.is_a?(Proc)
          factory = factory.call({hello: 3}) # blew up because I wasn't passing anything in to it, but passing {} into it fixed it now
        end
	  		@coord ||= invalid_point? ? nil : factory.point(@lon,@lat)
	  	end

	  	private

	  	def within_bounds?
	  		@lon.between?(-180.0,180.0) && @lat.between?(-90.0,90.0)
	  	end

	  end
	end
end