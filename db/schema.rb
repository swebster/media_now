# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_10_06_114111) do
  create_table "local_packages", force: :cascade do |t|
    t.integer "package_id", null: false
    t.integer "municipality_id", null: false
    t.integer "amount_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["municipality_id"], name: "index_local_packages_on_municipality_id"
    t.index ["package_id", "municipality_id"], name: "index_local_packages_on_package_id_and_municipality_id", unique: true
    t.index ["package_id"], name: "index_local_packages_on_package_id"
  end

  create_table "local_prices", force: :cascade do |t|
    t.integer "local_package_id", null: false
    t.integer "amount_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.virtual "created_year", type: :integer, null: false, as: "cast(strftime('%Y', created_at) as int)", stored: false
    t.virtual "created_month", type: :integer, null: false, as: "cast(strftime('%m', created_at) as int)", stored: false
    t.virtual "created_day", type: :integer, null: false, as: "cast(strftime('%d', created_at) as int)", stored: false
    t.index ["local_package_id", "created_year", "created_month", "created_day"], name: "index_local_prices_on_created_date"
    t.index ["local_package_id"], name: "index_local_prices_on_local_package_id"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name", limit: 15, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_municipalities_on_name", unique: true
  end

  create_table "packages", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_packages_on_name", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.integer "amount_cents", null: false
    t.integer "package_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_prices_on_package_id"
  end

  add_foreign_key "local_packages", "municipalities", on_delete: :cascade
  add_foreign_key "local_packages", "packages", on_delete: :cascade
  add_foreign_key "local_prices", "local_packages", on_delete: :cascade
  add_foreign_key "prices", "packages"
end
