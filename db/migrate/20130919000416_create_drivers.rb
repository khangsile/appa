class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.integer :user_id
      t.boolean :status
      t.decimal :balance
      t.decimal :fee

      t.timestamps
    end
  end
end
