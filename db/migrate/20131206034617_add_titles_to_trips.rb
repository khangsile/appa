class AddTitlesToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :start_title, :string
  	add_column :trips, :end_title, :string
  end
end
