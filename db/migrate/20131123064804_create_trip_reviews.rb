class CreateTripReviews < ActiveRecord::Migration
  def change
    create_table :trip_reviews do |t|
    	t.string :description, limit: 255
    	t.integer :user_id, index: true
    	t.integer :trip_id, index: true
    	t.integer :rating
    end
  end
end
