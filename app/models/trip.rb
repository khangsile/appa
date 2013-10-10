class Trip < ActiveRecord::Base
	set_rgeo_factory_for_column(:latlon,
    RGeo::Geographic.spherical_factory(:srid => 4326))	
	
	has_many :requests

	validate :driver_id, presence: true
	validate :latlon, presence: true
end
