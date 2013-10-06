class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :driver_id
      t.datetime :start_time

      t.timestamps
    end
  end
end
