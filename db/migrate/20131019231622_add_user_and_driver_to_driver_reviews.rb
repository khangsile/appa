class AddUserAndDriverToDriverReviews < ActiveRecord::Migration
  def change
    add_column :driver_reviews, :user_id, :integer
    add_column :driver_reviews, :driver_id, :integer
    add_index :driver_reviews, :user_id
    add_index :driver_reviews, :driver_id
  end
end
