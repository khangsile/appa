class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer   :driver_id, index: true
      t.integer   :user_id, index: true
      t.integer   :trip_id, index: true
      t.datetime  :time_sent
      t.datetime  :time_accepted
      t.boolean   :accepted, default: false
      t.string    :confirmation_code

      t.timestamps
    end
  end
end
