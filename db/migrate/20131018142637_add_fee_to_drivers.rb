class AddFeeToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :fee, :decimal, precision: 10, scale: 2
  end
end
