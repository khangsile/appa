class ChangeRequestsTable < ActiveRecord::Migration
  def change
  	remove_column :requests, :driver_id
  	remove_column :requests, :time_accepted
  	remove_column :requests, :confirmation_code  	
  end
end
