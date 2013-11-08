class Trip < ActiveRecord::Base
	set_rgeo_factory_for_column(:start_location,
    RGeo::Geographic.spherical_factory(:srid => 4326))	

	set_rgeo_factory_for_column(:end_location,
    RGeo::Geographic.spherical_factory(:srid => 4326))	

	has_many :requests

	validate :driver_id, presence: true
	validate :start_location, presence: true
	validate :end_location, presence: true
end
