class ChangeTripsColumns < ActiveRecord::Migration
  def change
  	remove_column :trips, :driver_id
  	add_column :trips, :cost, :decimal, precision: 10, scale: 2
  	add_column :trips, :min_seats, :integer
  	add_column :trips, :owner_id, :integer
  	add_column :trips, :driver_id, :integer
  end
end
