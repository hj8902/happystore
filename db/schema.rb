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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_products", force: :cascade do |t|
    t.bigserial "category_id", null: false
    t.bigserial "product_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id", "product_id"], name: "categories_products_category_id_product_id_key", unique: true
    t.index ["category_id"], name: "idx_categories_products_category"
  end

  create_table "category_hierarchies", force: :cascade do |t|
    t.bigserial "category_id", null: false
    t.bigserial "parent_category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id", "parent_category_id"], name: "category_hierarchies_category_id_parent_category_id_key", unique: true
  end

  create_table "price_lines", force: :cascade do |t|
    t.integer "min_price", null: false
    t.integer "max_price", null: false
  end

  create_table "price_lines_products", force: :cascade do |t|
    t.bigserial "product_id", null: false
    t.bigserial "price_line_id", null: false
    t.index ["product_id", "price_line_id"], name: "price_lines_products_product_id_price_line_id_key", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.text "name", null: false
    t.integer "price", null: false
    t.integer "quantity", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: :cascade do |t|
    t.bigserial "product_id", null: false
    t.text "description"
    t.integer "percentage", null: false
    t.integer "price", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "sales_product_id_key", unique: true
  end

end
