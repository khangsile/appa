class RemoveFeeFromDrivers < ActiveRecord::Migration
  def change
    remove_column :drivers, :fee, :float
    remove_column :drivers, :status, :boolean
  end
end
