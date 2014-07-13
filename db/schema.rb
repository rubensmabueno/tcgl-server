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

ActiveRecord::Schema.define(version: 20140413023056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: true do |t|
    t.string   "ip"
    t.integer  "line_stop_line_stop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accesses", ["line_stop_line_stop_id"], name: "index_accesses_on_line_stop_line_stop_id", using: :btree

  create_table "accesses_line_stops", force: true do |t|
    t.integer  "line_id"
    t.integer  "day_id"
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.integer  "access_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accesses_line_stops", ["access_id"], name: "index_accesses_line_stops_on_access_id", using: :btree
  add_index "accesses_line_stops", ["day_id"], name: "index_accesses_line_stops_on_day_id", using: :btree
  add_index "accesses_line_stops", ["destination_id"], name: "index_accesses_line_stops_on_destination_id", using: :btree
  add_index "accesses_line_stops", ["line_id"], name: "index_accesses_line_stops_on_line_id", using: :btree
  add_index "accesses_line_stops", ["origin_id"], name: "index_accesses_line_stops_on_origin_id", using: :btree

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "postal_code"
    t.integer  "neighbourhood_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["neighbourhood_id"], name: "index_addresses_on_neighbourhood_id", using: :btree
  add_index "addresses", ["state_id"], name: "index_addresses_on_state_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "days", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itineraries", force: true do |t|
    t.string   "name"
    t.integer  "to"
    t.integer  "order"
    t.decimal  "lat"
    t.decimal  "lng"
    t.decimal  "distance"
    t.integer  "line_id"
    t.integer  "address_id"
    t.integer  "stop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "itineraries", ["address_id"], name: "index_itineraries_on_address_id", using: :btree
  add_index "itineraries", ["line_id"], name: "index_itineraries_on_line_id", using: :btree
  add_index "itineraries", ["stop_id"], name: "index_itineraries_on_stop_id", using: :btree

  create_table "line_stops", force: true do |t|
    t.integer  "line_id"
    t.integer  "stop_id"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_stops", ["day_id"], name: "index_line_stops_on_day_id", using: :btree
  add_index "line_stops", ["line_id"], name: "index_line_stops_on_line_id", using: :btree
  add_index "line_stops", ["stop_id"], name: "index_line_stops_on_stop_id", using: :btree

  create_table "line_stops_line_stops", force: true do |t|
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_stops_line_stops", ["destination_id"], name: "index_line_stops_line_stops_on_destination_id", using: :btree
  add_index "line_stops_line_stops", ["origin_id"], name: "index_line_stops_line_stops_on_origin_id", using: :btree

  create_table "lines", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "type_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lines", ["type_line_id"], name: "index_lines_on_type_line_id", using: :btree

  create_table "neighbourhoods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "bus"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["line_id"], name: "index_positions_on_line_id", using: :btree

  create_table "schedules", force: true do |t|
    t.time     "departure"
    t.time     "arrive"
    t.integer  "line_stop_line_stop_id"
    t.string   "via"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["line_stop_line_stop_id"], name: "index_schedules_on_line_stop_line_stop_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stops", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_lines", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
