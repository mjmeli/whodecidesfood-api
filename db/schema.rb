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

ActiveRecord::Schema.define(version: 20170131015442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comparisons", force: :cascade do |t|
    t.string   "title",      default: ""
    t.integer  "owner_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["owner_id"], name: "index_comparisons_on_owner_id", using: :btree
  end

  create_table "decisions", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "comparison_id"
    t.string   "location",       default: ""
    t.string   "meal",           default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["comparison_id"], name: "index_decisions_on_comparison_id", using: :btree
    t.index ["participant_id"], name: "index_decisions_on_participant_id", using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "comparison_id"
    t.string   "name"
    t.integer  "score",         default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["comparison_id"], name: "index_participants_on_comparison_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "decisions", "comparisons"
  add_foreign_key "decisions", "participants"
  add_foreign_key "participants", "comparisons"
end
