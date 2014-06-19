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

ActiveRecord::Schema.define(version: 20140614154200) do

  create_table "orders", force: true do |t|
    t.string   "express_token"
    t.string   "payer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "payer"
    t.string   "name"
    t.string   "street1"
    t.string   "street2"
    t.string   "city_name"
    t.string   "state_or_province"
    t.string   "country"
    t.string   "country_name"
    t.string   "postal_code"
    t.string   "order_total"
    t.string   "order_total_currency_id"
    t.integer  "mentor_id"
    t.integer  "user_id"
  end

  add_index "orders", ["mentor_id"], name: "index_orders_on_mentor_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                                           default: "", null: false
    t.string   "encrypted_password",                              default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.text     "bio"
    t.text     "school_name"
    t.integer  "degree_year"
    t.text     "hometown"
    t.text     "field_of_study"
    t.text     "major"
    t.text     "other_acceptances"
    t.text     "other_waitlists"
    t.text     "applied_early"
    t.integer  "SAT_total"
    t.integer  "SAT_math"
    t.integer  "SAT_reading"
    t.integer  "SAT_writing"
    t.integer  "ACT_composite"
    t.text     "class_rank"
    t.text     "main_high_school_awards"
    t.text     "main_extracurricular_activities"
    t.text     "job_experience"
    t.text     "volunteer_experience"
    t.text     "summer_activities"
    t.text     "my_strengths"
    t.text     "my_weaknesses"
    t.text     "why_i_think_i_was_accepted"
    t.text     "biggest_piece_of_advice_to_high_school_students"
    t.text     "avatar"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
