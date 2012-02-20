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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120217205044) do

  create_table "carts", :force => true do |t|
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "line_items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.decimal  "unit_price", :default => 0.0
    t.integer  "quantity",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.decimal  "unit_price",  :default => 0.0
  end

  add_index "products", ["name"], :name => "index_products_on_name", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "sub_category_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["product_id"], :name => "index_relationships_on_product_id"
  add_index "relationships", ["sub_category_id"], :name => "index_relationships_on_sub_category_id"

  create_table "sub_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_categories", ["category_id"], :name => "index_sub_categories_on_category_id"
  add_index "sub_categories", ["name"], :name => "index_sub_categories_on_name"

end
