# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131128060825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "cars", force: true do |t|
    t.integer  "driver_id"
    t.string   "model"
    t.integer  "year"
    t.integer  "num_seats"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "make"
  end

  create_table "devices", force: true do |t|
    t.string  "registration_id"
    t.integer "user_id"
    t.string  "platform"
  end

  create_table "driver_reviews", force: true do |t|
    t.integer  "rating"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_id"
    t.integer  "user_id"
    t.integer  "driver_id"
  end

  add_index "driver_reviews", ["driver_id"], :name => "index_driver_reviews_on_driver_id"
  add_index "driver_reviews", ["request_id"], :name => "index_driver_reviews_on_brequest_id"
  add_index "driver_reviews", ["user_id"], :name => "index_driver_reviews_on_user_id"

  create_table "drivers", force: true do |t|
    t.integer  "user_id"
    t.decimal  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "location",   limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.decimal  "fee",                                                                 precision: 10, scale: 2
    t.boolean  "active"
    t.decimal  "rating",                                                              precision: 2,  scale: 1
  end

  add_index "drivers", ["location"], :name => "index_drivers_on_location", :spatial => true

  create_table "posts", force: true do |t|
    t.integer "trip_id"
    t.integer "user_id"
    t.string  "content"
  end

  create_table "requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "time_sent"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_reviews", force: true do |t|
    t.string  "description"
    t.integer "user_id"
    t.integer "trip_id"
    t.integer "rating"
  end

  create_table "trips", force: true do |t|
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "start_location", limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.spatial  "end_location",   limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.decimal  "cost",                                                                    precision: 10, scale: 2
    t.integer  "min_seats"
    t.integer  "owner_id"
    t.integer  "driver_id"
    t.string   "title"
  end

  add_index "trips", ["end_location"], :name => "index_trips_on_end_location", :spatial => true
  add_index "trips", ["start_location"], :name => "index_trips_on_start_location", :spatial => true

  create_table "user_reviews", force: true do |t|
    t.integer  "rating"
    t.string   "content"
    t.integer  "reviewer_id"
    t.integer  "reviewee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "authentication_token"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
