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

ActiveRecord::Schema.define(version: 20150412134017) do

  create_table "custom_field_values", force: :cascade do |t|
    t.integer  "custom_field_id"
    t.integer  "customizable_id"
    t.string   "customizable_type"
    t.string   "value"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "custom_field_values", ["custom_field_id", "customizable_id", "customizable_type"], name: "custom_field_values_index"

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

  create_table "open_portal_clients_clients", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_portal_employees_employees", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_portal_employees_phones", force: :cascade do |t|
    t.string   "number"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "open_portal_employees_phones", ["employee_id"], name: "index_open_portal_employees_phones_on_employee_id"

  create_table "open_portal_result_control_billings", force: :cascade do |t|
    t.float    "value"
    t.date     "expected_date"
    t.date     "date"
    t.integer  "competence_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "open_portal_result_control_billings", ["competence_id"], name: "index_open_portal_result_control_billings_on_competence_id"

  create_table "open_portal_result_control_competences", force: :cascade do |t|
    t.integer  "year"
    t.float    "january"
    t.float    "february"
    t.float    "march"
    t.float    "abril"
    t.float    "may"
    t.float    "june"
    t.float    "july"
    t.float    "august"
    t.float    "september"
    t.float    "october"
    t.float    "november"
    t.float    "december"
    t.integer  "sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "open_portal_result_control_competences", ["sale_id"], name: "index_open_portal_result_control_competences_on_sale_id"

  create_table "open_portal_result_control_payments", force: :cascade do |t|
    t.float    "value"
    t.date     "expected_date"
    t.date     "date"
    t.integer  "billing_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "open_portal_result_control_payments", ["billing_id"], name: "index_open_portal_result_control_payments_on_billing_id"

  create_table "open_portal_result_control_sales", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "title"
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "open_portal_result_control_sales", ["client_id"], name: "index_open_portal_result_control_sales_on_client_id"

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

  add_index "permissions_groups_users", ["permissions_group_id", "user_id"], name: "group_user_index"
  add_index "permissions_groups_users", ["user_id"], name: "index_permissions_groups_users_on_user_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
