class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer   :driver_id
      t.integer   :user_id
      t.integer   :trip_id
      t.datetime  :time_sent
      t.datetime  :time_accepted
      t.boolean   :accepted
      t.string    :confirmation_code

      t.timestamps
    end
  end
end
