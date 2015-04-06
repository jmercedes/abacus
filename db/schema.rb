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

ActiveRecord::Schema.define(version: 20150330205444) do

  create_table "assets", force: true do |t|
    t.integer "profile_id"
    t.string  "name"
    t.text    "description"
    t.float   "commercial_value"
    t.string  "ownership_status"
    t.float   "amount_owned"
    t.float   "amount_debt"
  end

  create_table "contract_templates", force: true do |t|
    t.integer  "investment_contract_id"
    t.string   "type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_assignments", force: true do |t|
    t.float "amount"
    t.float "rate"
    t.float "period_of_time"
  end

  create_table "guarantors", force: true do |t|
    t.integer "profile_id"
    t.string  "first_name"
    t.string  "second_name"
    t.string  "first_last_name"
    t.string  "second_last_name"
    t.string  "personal_identification_number"
    t.string  "birth_date"
    t.string  "gender"
    t.string  "nationality"
    t.string  "address"
    t.string  "city"
    t.string  "province"
    t.string  "zipcode"
    t.string  "residence_phone_number"
    t.string  "mobile_phone_number"
  end

  create_table "investment_contracts", force: true do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.float    "rate"
    t.float    "period_of_time"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loan_applications", force: true do |t|
    t.float "amount"
    t.float "rate"
  end

  create_table "loan_types", force: true do |t|
    t.integer "loan_id"
    t.string  "name"
  end

  create_table "loans", force: true do |t|
    t.float    "amount"
    t.string   "status"
    t.float    "rate"
    t.integer  "time_frame"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "names"
    t.string   "lastnames"
    t.string   "personal_identification_number"
    t.string   "nationality"
    t.string   "social_status"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "profession"
    t.string   "scholar_degree"
    t.string   "residence_phone_number"
    t.string   "mobile_phone_number"
    t.string   "office_phone_number"
    t.string   "residence_status"
    t.integer  "time_living_in_current_residence"
    t.string   "address"
    t.string   "address_2"
    t.string   "address_reference"
    t.string   "city"
    t.string   "sector"
    t.string   "province"
    t.string   "country"
    t.string   "job_status"
    t.boolean  "currently_working"
    t.string   "business_name"
    t.string   "business_social_reason"
    t.string   "business_phone"
    t.string   "job_position"
    t.string   "time_in_current_job"
    t.string   "monthly_income"
    t.string   "prior_job"
    t.string   "other_income"
    t.string   "father_names"
    t.string   "father_lastnames"
    t.string   "father_personal_identification_number"
    t.string   "father_residence_phone_number"
    t.string   "father_mobile_phone_number"
    t.string   "father_birthdate"
    t.string   "father_address"
    t.string   "father_address_2"
    t.string   "father_city"
    t.string   "father_sector"
    t.string   "father_province"
    t.string   "father_country"
    t.string   "mother_names"
    t.string   "mother_lastnames"
    t.string   "mother_residence_phone_number"
    t.string   "mother_mobile_phone_number"
    t.string   "mother_birthdate"
    t.string   "mother_address"
    t.string   "mother_address_2"
    t.string   "mother_city"
    t.string   "mother_sector"
    t.string   "mother_province"
    t.string   "mother_country"
    t.string   "spouse_names"
    t.string   "spouse_lastnames"
    t.string   "spouse_personal_identification_number"
    t.string   "spouse_mobile_phone_number"
    t.string   "spouse_birthdate"
    t.string   "spouse_job_place"
    t.string   "spouse_job_position"
    t.string   "spouse_monthly_salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "progress_status",                       default: 0, null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "references", force: true do |t|
    t.integer "profile_id"
    t.string  "name"
    t.string  "last_name"
    t.string  "personal_identification_number"
    t.string  "residence_phone_number"
    t.string  "mobile_phone_number"
    t.string  "linkage"
  end

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
