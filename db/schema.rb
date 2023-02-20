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

ActiveRecord::Schema.define(version: 2019_06_02_165911) do

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.string "phone"
    t.string "email"
    t.string "description"
    t.string "rejection_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "liability_insurance", default: false
    t.string "primary_name"
    t.string "secondary_name"
    t.string "secondary_phone"
    t.string "title"
    t.integer "transportation"
    t.index ["email"], name: "index_organizations_on_email", unique: true
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "organizations_resource_categories", id: false, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "resource_category_id", null: false
    t.index ["organization_id", "resource_category_id"], name: "organization_resource_category"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resource_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "phone"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "closed", default: false
    t.datetime "closed_at"
    t.integer "resource_category_id"
    t.integer "region_id"
    t.index ["organization_id"], name: "index_tickets_on_organization_id"
    t.index ["region_id"], name: "index_tickets_on_region_id"
    t.index ["resource_category_id"], name: "index_tickets_on_resource_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role", default: 1
    t.integer "organization_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
