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

ActiveRecord::Schema.define(version: 20150614155235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_field_values", force: :cascade do |t|
    t.integer  "custom_field_id"
    t.integer  "customizable_id"
    t.string   "customizable_type"
    t.string   "value"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "custom_field_values", ["custom_field_id", "customizable_id", "customizable_type"], name: "custom_field_values_index", using: :btree

  create_table "custom_fields", force: :cascade do |t|
    t.string   "field_name"
    t.string   "field_type"
    t.boolean  "required"
    t.string   "customizable_model_name"
    t.text     "allowed_values"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "formula"
  end

  create_table "op_coupons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "op_sale_id"
    t.string   "authentication_token"
    t.boolean  "active",               default: true
    t.date     "due_date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "op_coupons", ["authentication_token"], name: "index_op_coupons_on_authentication_token", using: :btree
  add_index "op_coupons", ["op_sale_id"], name: "index_op_coupons_on_op_sale_id", using: :btree
  add_index "op_coupons", ["user_id"], name: "index_op_coupons_on_user_id", using: :btree

  create_table "op_sales", force: :cascade do |t|
    t.integer  "store_id"
    t.text     "description"
    t.string   "type"
    t.integer  "max_points"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "op_sales", ["store_id"], name: "index_op_sales_on_store_id", using: :btree

  create_table "op_shopping_records", force: :cascade do |t|
    t.integer  "points"
    t.integer  "user_id"
    t.integer  "op_sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "op_shopping_records", ["op_sale_id"], name: "index_op_shopping_records_on_op_sale_id", using: :btree
  add_index "op_shopping_records", ["user_id"], name: "index_op_shopping_records_on_user_id", using: :btree

  create_table "op_stores", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_groups", force: :cascade do |t|
    t.string   "name"
    t.text     "permissions"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "permissions_groups_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "permissions_group_id"
  end

  add_index "permissions_groups_users", ["permissions_group_id", "user_id"], name: "group_user_index", using: :btree
  add_index "permissions_groups_users", ["user_id"], name: "index_permissions_groups_users_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.text     "preferences"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "op_store_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["op_store_id"], name: "index_users_on_op_store_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "custom_field_values", "custom_fields"
  add_foreign_key "op_coupons", "op_sales"
  add_foreign_key "op_coupons", "users"
  add_foreign_key "op_sales", "op_stores", column: "store_id"
  add_foreign_key "op_shopping_records", "op_sales"
  add_foreign_key "op_shopping_records", "users"
  add_foreign_key "users", "op_stores"
end
