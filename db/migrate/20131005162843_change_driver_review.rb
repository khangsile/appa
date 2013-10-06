class ChangeDriverReview < ActiveRecord::Migration
  def change
  	remove_column :driver_reviews, :trip_id
  	remove_column :driver_reviews, :user_id
  	remove_column :driver_reviews, :driver_id
  	add_reference :driver_reviews, :request, index: true
  end
end
