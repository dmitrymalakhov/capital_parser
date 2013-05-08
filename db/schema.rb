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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130508071339) do

  create_table "brands", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["store_id"], :name => "index_categories_on_store_id"

  create_table "pavilion_descriptions", :force => true do |t|
    t.string   "logo"
    t.text     "content"
    t.string   "floor"
    t.string   "site"
    t.integer  "pavilion_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "pavilion_descriptions", ["pavilion_id"], :name => "index_pavilion_descriptions_on_pavilion_id"

  create_table "pavilion_galleries", :force => true do |t|
    t.string   "image"
    t.integer  "pavilion_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "pavilion_galleries", ["pavilion_id"], :name => "index_pavilion_galleries_on_pavilion_id"

  create_table "pavilions", :force => true do |t|
    t.integer  "category_id"
    t.integer  "brand_id"
    t.integer  "pavilion_description_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "pavilions", ["brand_id"], :name => "index_pavilions_on_brand_id"
  add_index "pavilions", ["category_id"], :name => "index_pavilions_on_category_id"
  add_index "pavilions", ["pavilion_description_id"], :name => "index_pavilions_on_pavilion_description_id"

  create_table "stores", :force => true do |t|
    t.string   "title"
    t.string   "base_url"
    t.string   "pavilion_url"
    t.string   "news_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end