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

ActiveRecord::Schema.define(:version => 20130529102715) do

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

  create_table "credits", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "credits_pavilions", :id => false, :force => true do |t|
    t.integer "credit_id"
    t.integer "pavilion_id"
  end

  add_index "credits_pavilions", ["credit_id", "pavilion_id"], :name => "index_credits_pavilions_on_credit_id_and_pavilion_id"
  add_index "credits_pavilions", ["pavilion_id", "credit_id"], :name => "index_credits_pavilions_on_pavilion_id_and_credit_id"

  create_table "discounts", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.string   "percentage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discounts_pavilions", :id => false, :force => true do |t|
    t.integer "discount_id"
    t.integer "pavilion_id"
  end

  add_index "discounts_pavilions", ["discount_id", "pavilion_id"], :name => "index_discounts_pavilions_on_discount_id_and_pavilion_id"
  add_index "discounts_pavilions", ["pavilion_id", "discount_id"], :name => "index_discounts_pavilions_on_pavilion_id_and_discount_id"

  create_table "film_schedules", :force => true do |t|
    t.integer  "store_id"
    t.integer  "film_id"
    t.string   "option"
    t.string   "auditorium"
    t.string   "time"
    t.integer  "price"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "film_schedules", ["store_id"], :name => "index_film_schedules_on_store_id"

  create_table "films", :force => true do |t|
    t.string   "title"
    t.string   "poster"
    t.string   "engtitle"
    t.string   "genre"
    t.string   "duration"
    t.string   "in_theaters"
    t.string   "production"
    t.string   "producer"
    t.string   "actors"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.string   "date_publication"
    t.text     "content"
    t.integer  "store_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "news", ["store_id"], :name => "index_news_on_store_id"

  create_table "news_galleries", :force => true do |t|
    t.string   "image"
    t.integer  "news_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "news_galleries", ["news_id"], :name => "index_news_galleries_on_news_id"

  create_table "pavilion_descriptions", :force => true do |t|
    t.string   "logo"
    t.text     "content"
    t.string   "floor"
    t.string   "site"
    t.string   "phone"
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
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "pavilions", ["brand_id"], :name => "index_pavilions_on_brand_id"
  add_index "pavilions", ["category_id"], :name => "index_pavilions_on_category_id"

  create_table "stores", :force => true do |t|
    t.string   "title"
    t.string   "base_url"
    t.string   "pavilion_url"
    t.string   "services_url"
    t.string   "cinema_url"
    t.string   "news_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
