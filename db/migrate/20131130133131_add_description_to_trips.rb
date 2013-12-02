class AddDescriptionToTrips < ActiveRecord::Migration
  def change
  	remove_column :trips, :title
  	add_column :trips, :description, :string
  end
end
