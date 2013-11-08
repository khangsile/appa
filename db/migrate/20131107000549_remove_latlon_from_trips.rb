class RemoveLatlonFromTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :start_location, :point, geographic: true
  	add_column :trips, :end_location, :point, geographic: true
  	remove_column :trips, :latlon
  	add_index :trips, :start_location, spatial: true
  	add_index :trips, :end_location, spatial: true
  end
end
