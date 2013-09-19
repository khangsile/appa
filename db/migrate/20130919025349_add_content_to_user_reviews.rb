class AddContentToUserReviews < ActiveRecord::Migration
  def change
    add_column :user_reviews, :content, :string
  end
end
