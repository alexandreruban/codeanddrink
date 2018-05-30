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

ActiveRecord::Schema.define(version: 2018_05_30_102856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.text "player_input"
    t.text "spec_output"
    t.string "status"
    t.bigint "round_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_attempts_on_player_id"
    t.index ["round_id"], name: "index_attempts_on_round_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.text "rules"
    t.text "specs"
    t.text "solution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "template"
  end

  create_table "game_masters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_game_masters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_game_masters_on_reset_password_token", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "wifi_network"
    t.string "wifi_password"
    t.bigint "game_master_id"
    t.datetime "starts_at"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_master_id"], name: "index_games_on_game_master_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.string "status"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "state"
    t.integer "number_of_winners"
    t.bigint "game_id"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_rounds_on_exercise_id"
    t.index ["game_id"], name: "index_rounds_on_game_id"
  end

  add_foreign_key "attempts", "players"
  add_foreign_key "attempts", "rounds"
  add_foreign_key "games", "game_masters"
  add_foreign_key "players", "games"
  add_foreign_key "rounds", "exercises"
  add_foreign_key "rounds", "games"
end
