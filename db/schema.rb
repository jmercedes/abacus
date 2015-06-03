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

ActiveRecord::Schema.define(version: 20150531144018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string  "name"
    t.string  "number"
    t.text    "description"
    t.decimal "amount",      precision: 8, scale: 2
    t.integer "company_id"
  end

  add_index "accounts", ["company_id"], name: "index_accounts_on_company_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "assets", force: :cascade do |t|
    t.integer "profile_id"
    t.string  "name"
    t.text    "description"
    t.float   "commercial_value"
    t.string  "ownership_status"
    t.float   "amount_owned"
    t.float   "amount_debt"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
  end

  create_table "contract_templates", force: :cascade do |t|
    t.integer  "investment_contract_id"
    t.string   "type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", force: :cascade do |t|
    t.decimal  "amount",     precision: 8, scale: 2
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deposits", ["account_id"], name: "index_deposits_on_account_id", using: :btree

  create_table "fund_assignments", force: :cascade do |t|
    t.float "amount"
    t.float "rate"
    t.float "period_of_time"
  end

  create_table "guarantors", force: :cascade do |t|
    t.integer "profile_id"
    t.string  "first_name"
    t.string  "second_name"
    t.string  "first_last_name"
    t.string  "second_last_name"
    t.string  "personal_identification_number"
    t.date    "birth_date"
    t.string  "gender"
    t.string  "nationality"
    t.string  "address"
    t.string  "city"
    t.string  "province"
    t.string  "zipcode"
    t.string  "residence_phone_number"
    t.string  "mobile_phone_number"
  end

  create_table "investment_contracts", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.float    "rate"
    t.float    "period_of_time"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loan_applications", force: :cascade do |t|
    t.float "amount"
    t.float "rate"
  end

  create_table "loan_types", force: :cascade do |t|
    t.integer "loan_id"
    t.string  "name"
  end

  create_table "loans", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount"
    t.decimal  "financing_rate"
    t.integer  "financing_time"
    t.date     "emision_date"
    t.integer  "user_id"
    t.string   "status",         default: "pending"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.date    "payment_date"
    t.integer "loan_id"
    t.decimal "late_fee",        default: 0.0
    t.decimal "capital_payment", default: 0.0
  end

  create_table "profiles", force: :cascade do |t|
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
    t.date     "father_birthdate"
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
    t.date     "mother_birthdate"
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
    t.date     "spouse_birthdate"
    t.string   "spouse_job_place"
    t.string   "spouse_job_position"
    t.string   "spouse_monthly_salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "progress_status",                       default: 0, null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.integer "profile_id"
    t.string  "name"
    t.string  "last_name"
    t.string  "personal_identification_number"
    t.string  "residence_phone_number"
    t.string  "mobile_phone_number"
    t.string  "linkage"
  end

  create_table "refinery_blog_categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "slug",       limit: 255
  end

  add_index "refinery_blog_categories", ["id"], name: "index_refinery_blog_categories_on_id", using: :btree
  add_index "refinery_blog_categories", ["slug"], name: "index_refinery_blog_categories_on_slug", using: :btree

  create_table "refinery_blog_categories_blog_posts", force: :cascade do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
  end

  add_index "refinery_blog_categories_blog_posts", ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp", using: :btree

  create_table "refinery_blog_category_translations", force: :cascade do |t|
    t.integer  "refinery_blog_category_id"
    t.string   "locale",                    limit: 255, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "title",                     limit: 255
    t.string   "slug",                      limit: 255
  end

  add_index "refinery_blog_category_translations", ["locale"], name: "index_refinery_blog_category_translations_on_locale", using: :btree
  add_index "refinery_blog_category_translations", ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31", using: :btree

  create_table "refinery_blog_comments", force: :cascade do |t|
    t.integer  "blog_post_id"
    t.boolean  "spam"
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.text     "body"
    t.string   "state",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "refinery_blog_comments", ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id", using: :btree
  add_index "refinery_blog_comments", ["id"], name: "index_refinery_blog_comments_on_id", using: :btree

  create_table "refinery_blog_post_translations", force: :cascade do |t|
    t.integer  "refinery_blog_post_id"
    t.string   "locale",                limit: 255, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "body"
    t.text     "custom_teaser"
    t.string   "custom_url",            limit: 255
    t.string   "slug",                  limit: 255
    t.string   "title",                 limit: 255
  end

  add_index "refinery_blog_post_translations", ["locale"], name: "index_refinery_blog_post_translations_on_locale", using: :btree
  add_index "refinery_blog_post_translations", ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id", using: :btree

  create_table "refinery_blog_posts", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "body"
    t.boolean  "draft"
    t.datetime "published_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id"
    t.string   "custom_url",       limit: 255
    t.text     "custom_teaser"
    t.string   "source_url",       limit: 255
    t.string   "source_url_title", limit: 255
    t.integer  "access_count",                 default: 0
    t.string   "slug",             limit: 255
  end

  add_index "refinery_blog_posts", ["access_count"], name: "index_refinery_blog_posts_on_access_count", using: :btree
  add_index "refinery_blog_posts", ["id"], name: "index_refinery_blog_posts_on_id", using: :btree
  add_index "refinery_blog_posts", ["slug"], name: "index_refinery_blog_posts_on_slug", using: :btree

  create_table "refinery_companies", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.float    "price"
    t.string   "status",      limit: 255
    t.integer  "position"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "refinery_company_requests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "company",    limit: 255
    t.text     "message"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "refinery_company_requests", ["id"], name: "index_refinery_company_requests_on_id", using: :btree

  create_table "refinery_images", force: :cascade do |t|
    t.string   "image_mime_type", limit: 255
    t.string   "image_name",      limit: 255
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid",       limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "refinery_inquiries_inquiries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.text     "message"
    t.boolean  "spam",                   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "refinery_inquiries_inquiries", ["id"], name: "index_refinery_inquiries_inquiries_on_id", using: :btree

  create_table "refinery_page_part_translations", force: :cascade do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale",                limit: 255, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "body"
  end

  add_index "refinery_page_part_translations", ["locale"], name: "index_refinery_page_part_translations_on_locale", using: :btree
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id", using: :btree

  create_table "refinery_page_parts", force: :cascade do |t|
    t.integer  "refinery_page_id"
    t.string   "title",            limit: 255
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "refinery_page_parts", ["id"], name: "index_refinery_page_parts_on_id", using: :btree
  add_index "refinery_page_parts", ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id", using: :btree

  create_table "refinery_page_translations", force: :cascade do |t|
    t.integer  "refinery_page_id"
    t.string   "locale",           limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "title",            limit: 255
    t.string   "custom_slug",      limit: 255
    t.string   "menu_title",       limit: 255
    t.string   "slug",             limit: 255
  end

  add_index "refinery_page_translations", ["locale"], name: "index_refinery_page_translations_on_locale", using: :btree
  add_index "refinery_page_translations", ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id", using: :btree

  create_table "refinery_pages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "path",                limit: 255
    t.string   "slug",                limit: 255
    t.boolean  "show_in_menu",                    default: true
    t.string   "link_url",            limit: 255
    t.string   "menu_match",          limit: 255
    t.boolean  "deletable",                       default: true
    t.boolean  "draft",                           default: false
    t.boolean  "skip_to_first_child",             default: false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template",       limit: 255
    t.string   "layout_template",     limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "refinery_pages", ["depth"], name: "index_refinery_pages_on_depth", using: :btree
  add_index "refinery_pages", ["id"], name: "index_refinery_pages_on_id", using: :btree
  add_index "refinery_pages", ["lft"], name: "index_refinery_pages_on_lft", using: :btree
  add_index "refinery_pages", ["parent_id"], name: "index_refinery_pages_on_parent_id", using: :btree
  add_index "refinery_pages", ["rgt"], name: "index_refinery_pages_on_rgt", using: :btree

  create_table "refinery_practices", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "icon",        limit: 255
  end

  create_table "refinery_profiles", force: :cascade do |t|
    t.integer  "photo_id"
    t.string   "name",              limit: 255
    t.text     "bio"
    t.integer  "position"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "job_position",      limit: 255
    t.text     "areas_of_practice"
  end

  create_table "refinery_requests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "company",    limit: 255
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "refinery_requisitions", force: :cascade do |t|
    t.string   "company",    limit: 255
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.text     "message"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "refinery_requisitions", ["id"], name: "index_refinery_requisitions_on_id", using: :btree

  create_table "refinery_resources", force: :cascade do |t|
    t.string   "file_mime_type", limit: 255
    t.string   "file_name",      limit: 255
    t.integer  "file_size"
    t.string   "file_uid",       limit: 255
    t.string   "file_ext",       limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "refinery_roles", force: :cascade do |t|
    t.string "title", limit: 255
  end

  create_table "refinery_roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], name: "index_refinery_roles_users_on_role_id_and_user_id", using: :btree
  add_index "refinery_roles_users", ["user_id", "role_id"], name: "index_refinery_roles_users_on_user_id_and_role_id", using: :btree

  create_table "refinery_settings", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "value"
    t.boolean  "destroyable",                 default: true
    t.string   "scoping",         limit: 255
    t.boolean  "restricted",                  default: false
    t.string   "form_value_type", limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "slug",            limit: 255
  end

  add_index "refinery_settings", ["name"], name: "index_refinery_settings_on_name", using: :btree

  create_table "refinery_user_plugins", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name",     limit: 255
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], name: "index_refinery_user_plugins_on_name", using: :btree
  add_index "refinery_user_plugins", ["user_id", "name"], name: "index_refinery_user_plugins_on_user_id_and_name", unique: true, using: :btree

  create_table "refinery_users", force: :cascade do |t|
    t.string   "username",               limit: 255, null: false
    t.string   "email",                  limit: 255, null: false
    t.string   "encrypted_password",     limit: 255, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "slug",                   limit: 255
  end

  add_index "refinery_users", ["id"], name: "index_refinery_users_on_id", using: :btree
  add_index "refinery_users", ["slug"], name: "index_refinery_users_on_slug", using: :btree

  create_table "requests", force: :cascade do |t|
    t.integer  "financing_time"
    t.integer  "financing_rate",                         default: 0
    t.integer  "user_id"
    t.decimal  "amount",         precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                                 default: "pending"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "seo_meta", force: :cascade do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type",    limit: 255
    t.string   "browser_title",    limit: 255
    t.text     "meta_description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "seo_meta", ["id"], name: "index_seo_meta_on_id", using: :btree
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 255
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
