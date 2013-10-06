class AddTripColumnToDriverReview < ActiveRecord::Migration
  def change
    add_reference :driver_reviews, :trip
  end
end
