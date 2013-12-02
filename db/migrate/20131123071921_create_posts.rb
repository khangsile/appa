class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.integer :trip_id, index: true
    	t.integer :user_id, index: true
    	t.string :description, limit: 255
    end
  end
end
