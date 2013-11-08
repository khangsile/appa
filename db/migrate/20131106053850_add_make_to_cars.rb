class AddMakeToCars < ActiveRecord::Migration
  def change
  	add_column :cars, :make, :string
  end
end
