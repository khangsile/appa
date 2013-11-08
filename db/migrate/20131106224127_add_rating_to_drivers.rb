class AddRatingToDrivers < ActiveRecord::Migration
  def change
  	add_column :drivers, :rating, :decimal, precision: 2, scale: 1
  end
end
