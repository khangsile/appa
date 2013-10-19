class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :driver_id
      t.string :model
      t.integer :year
      t.integer :num_seats

      t.timestamps
    end
  end
end
