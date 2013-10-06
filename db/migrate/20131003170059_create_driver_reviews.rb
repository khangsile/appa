class CreateDriverReviews < ActiveRecord::Migration
  def change
    create_table :driver_reviews do |t|
    	t.integer :rating
    	t.string :content
    	t.belongs_to :reviewer, class_name: "Users"
    	t.belongs_to :reviewee, class_name: "Drivers"

      t.timestamps
    end
  end
end
