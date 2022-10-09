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

ActiveRecord::Schema[7.0].define(version: 2022_10_08_131828) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_session_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.string "size"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_session_id"], name: "index_cart_items_on_cart_session_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "cart_sessions", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "sum_money", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cart_sessions_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "microposts", force: :cascade do |t|
    t.string "content"
    t.string "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "product_id"
    t.integer "quantity"
    t.string "size"
    t.integer "price"
    t.string "name"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "sum_money"
    t.string "name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "shop_id"
    t.string "color"
    t.integer "price"
    t.integer "size_s", default: 0
    t.integer "size_m", default: 0
    t.integer "size_l", default: 0
    t.integer "size_xl", default: 0
    t.string "description"
    t.string "information"
    t.json "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.string "description"
    t.string "web_url"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.string "address"
    t.string "delivery_address"
    t.integer "admin", default: 0
    t.integer "role", default: 0
    t.string "image"
    t.string "delivery_name"
    t.string "delivery_number"
    t.string "remember_digest"
  end

end
