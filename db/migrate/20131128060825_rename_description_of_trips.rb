class RenameDescriptionOfTrips < ActiveRecord::Migration
  def change
  	rename_column :posts, :description, :content
  end
end
