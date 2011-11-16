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

ActiveRecord::Schema.define(:version => 20111116124241) do

  create_table "battle_types", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "battle_class",  :null => false
    t.text     "code_template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battles", :force => true do |t|
    t.string   "type",                                  :null => false
    t.integer  "creator_id",                            :null => false
    t.integer  "player_id"
    t.string   "status",             :default => "new", :null => false
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_program_id",                    :null => false
    t.integer  "player_program_id"
    t.integer  "rounds"
    t.integer  "winner_program_id"
    t.boolean  "public",             :default => true,  :null => false
  end

  add_index "battles", ["creator_id", "player_id"], :name => "index_battles_on_creator_id_and_player_id"
  add_index "battles", ["creator_program_id", "player_program_id"], :name => "index_battles_on_creator_program_id_and_player_program_id"
  add_index "battles", ["status"], :name => "index_battles_on_status"
  add_index "battles", ["winner_id"], :name => "index_battles_on_winner_id"
  add_index "battles", ["winner_program_id"], :name => "index_battles_on_winner_program_id"

  create_table "codabras", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "email",                                :null => false
    t.integer  "level",             :default => 1,     :null => false
    t.boolean  "active",            :default => false, :null => false
    t.string   "locale",            :default => "en",  :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "persistence_token",                    :null => false
  end

  add_index "codabras", ["email"], :name => "index_codabras_on_email", :unique => true
  add_index "codabras", ["name"], :name => "index_codabras_on_name", :unique => true

  create_table "programs", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "owner_id",     :null => false
    t.string   "battle_class", :null => false
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["owner_id"], :name => "index_programs_on_owner_id"

end
