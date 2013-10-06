class RenameEntitiesInDriverReviews < ActiveRecord::Migration
  def change
  	change_table :driver_reviews do |t|
  		t.rename :reviewer_id, :user_id
  		t.rename :reviewee_id, :driver_id
  	end
  end
end
