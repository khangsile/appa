class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
    	t.string :registration_id
    	t.integer :user_id, index: true
    	t.string :platform
    end
  end
end
