class AddLocationToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :location, :point, geographic: true
    add_index :drivers, :location, spatial: true
  end
end
