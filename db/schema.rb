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

ActiveRecord::Schema.define(version: 20170217161458) do

  create_table "dues", force: :cascade do |t|
    t.integer  "kind",       null: false
    t.string   "purpose",    null: false
    t.integer  "unit",       null: false
    t.decimal  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dues_members", id: false, force: :cascade do |t|
    t.integer "due_id"
    t.integer "member_id"
    t.index ["due_id"], name: "index_dues_members_on_due_id"
    t.index ["member_id"], name: "index_dues_members_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string   "fio",        null: false
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_members_on_status"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "member_id"
    t.decimal  "total",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_payments_on_member_id"
  end

  create_table "plots", force: :cascade do |t|
    t.string   "number"
    t.integer  "space"
    t.string   "cadastre"
    t.string   "ukrgosact"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_plots_on_member_id"
    t.index ["number"], name: "index_plots_on_number"
  end

  create_table "registers", force: :cascade do |t|
    t.integer  "plot_id"
    t.integer  "kind",            null: false
    t.string   "name"
    t.string   "number"
    t.integer  "initial_display"
    t.string   "seal"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["plot_id"], name: "index_registers_on_plot_id"
  end

  create_table "settings", force: :cascade do |t|
    t.decimal "price_electricity", null: false
    t.decimal "price_water",       null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "kind",          null: false
    t.decimal  "total",         null: false
    t.decimal  "price"
    t.integer  "start_display"
    t.integer  "end_display"
    t.integer  "difference"
    t.text     "details",       null: false
    t.integer  "payment_id"
    t.integer  "payable_id",    null: false
    t.string   "payable_type",  null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["payable_type", "payable_id"], name: "index_transactions_on_payable_type_and_payable_id"
    t.index ["payment_id"], name: "index_transactions_on_payment_id"
  end

end
