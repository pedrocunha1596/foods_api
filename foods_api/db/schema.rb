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

ActiveRecord::Schema.define(version: 2021_01_23_124415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "component_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.bigint "component_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["component_category_id"], name: "index_components_on_component_category_id"
  end

  create_table "compositions", force: :cascade do |t|
    t.decimal "quantity"
    t.bigint "food_id", null: false
    t.bigint "component_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["component_id"], name: "index_compositions_on_component_id"
    t.index ["food_id"], name: "index_compositions_on_food_id"
  end

  create_table "food_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.decimal "edible_portion"
    t.string "code"
    t.integer "energy_value"
    t.bigint "food_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_category_id"], name: "index_foods_on_food_category_id"
  end

  add_foreign_key "components", "component_categories"
  add_foreign_key "compositions", "components"
  add_foreign_key "compositions", "foods"
  add_foreign_key "foods", "food_categories"
end
