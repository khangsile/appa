class AddLatLonToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :latlon, :point, geographic: true
  end
end
