# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100718214232) do

  create_table "puzzle_games", :force => true do |t|
    t.integer  "swap_times"
    t.integer  "cycle_times"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time_in_milliseconds", :limit => 25, :precision => 25, :scale => 0, :default => 0
  end

  create_table "spot_activities", :force => true do |t|
    t.string   "address"
    t.float    "celsius"
    t.integer  "light"
    t.boolean  "sw1"
    t.boolean  "sw2"
    t.float    "accel"
    t.float    "accelx"
    t.float    "accely"
    t.float    "accelz"
    t.float    "rel_accel"
    t.float    "rel_accelx"
    t.float    "rel_accely"
    t.float    "rel_accelz"
    t.float    "tiltx"
    t.float    "tilty"
    t.float    "tiltz"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "time_in_milliseconds", :limit => 16777215
  end

end
