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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141001203513) do

  create_table "airforces", :force => true do |t|
    t.integer  "state_id"
    t.integer  "fighters",    :default => 0
    t.integer  "bombers",     :default => 0
    t.integer  "helicopters", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "points",      :default => 0
  end

  create_table "armies", :force => true do |t|
    t.integer  "state_id"
    t.integer  "tanks",               :default => 0
    t.integer  "active_troops",       :default => 0
    t.integer  "reserve_troops",      :default => 0
    t.integer  "paramilitary_troops", :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "points",              :default => 0
  end

  create_table "economies", :force => true do |t|
    t.integer  "state_id"
    t.integer  "gdp_ppp",        :default => 0
    t.integer  "gdp_per_capita", :default => 0
    t.float    "gdp_growth",     :default => 0.0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "goodness_indices", :force => true do |t|
    t.integer  "state_id"
    t.integer  "overall_rank"
    t.integer  "science_rank"
    t.integer  "cultural_rank"
    t.integer  "peace_security_rank"
    t.integer  "world_order_rank"
    t.integer  "prosperity_equality_rank"
    t.integer  "planet_climate_rank"
    t.integer  "health_rank"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "points",                   :default => 0
  end

  create_table "mncs", :force => true do |t|
    t.integer  "rank"
    t.integer  "state_id"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "points",     :default => 0
  end

  create_table "navies", :force => true do |t|
    t.integer  "state_id"
    t.integer  "aircraft_carriers",  :default => 0
    t.integer  "amphibious_ships",   :default => 0
    t.integer  "cruisers",           :default => 0
    t.integer  "destroyers",         :default => 0
    t.integer  "frigates",           :default => 0
    t.integer  "corvettes",          :default => 0
    t.integer  "patrol_boats",       :default => 0
    t.integer  "nuclear_submarines", :default => 0
    t.integer  "submarines",         :default => 0
    t.integer  "combat_aircraft",    :default => 0
    t.integer  "attack_helicopters", :default => 0
    t.integer  "nuclear_weapons",    :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "points",             :default => 0
  end

  create_table "powers", :force => true do |t|
    t.integer  "state_id"
    t.integer  "raw_population_score", :default => 0
    t.integer  "raw_economic_score",   :default => 0
    t.integer  "raw_military_score",   :default => 0
    t.integer  "raw_soft_score",       :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "country_code"
    t.string   "name"
    t.integer  "population",           :default => 0
    t.float    "population_growth",    :default => 0.0
    t.float    "internet_penetration", :default => 0.0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "population_score",     :default => 0
    t.integer  "economic_score",       :default => 0
    t.integer  "soft_power_score",     :default => 0
    t.integer  "mnc_points",           :default => 0
    t.integer  "technology_points",    :default => 0
    t.integer  "military_score",       :default => 0
    t.integer  "total_power_score",    :default => 0
  end

end
