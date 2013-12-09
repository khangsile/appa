class CreateFbProfilePic < ActiveRecord::Migration
  def change
    create_table :fb_profile_pics do |t|
    	t.string :url
    	t.integer :user_id, index: true
    end
  end
end
