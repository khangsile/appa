class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :user_id, index: true
    	t.integer :post_id, index: true
			t.string  :content, limit: 255    	
    end
  end
end
