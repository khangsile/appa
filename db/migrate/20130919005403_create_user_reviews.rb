class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      # The 5 star rating
    	t.integer :rating
    	t.string :content
    	t.belongs_to :reviewer, class_name: "Users"
    	t.belongs_to :reviewee, class_name: "Users"
    	
      t.timestamps
    end
  end
end
