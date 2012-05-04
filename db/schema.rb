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

ActiveRecord::Schema.define(:version => 20120504132656) do

  create_table "courses", :force => true do |t|
    t.string   "department"
    t.integer  "number"
    t.string   "name"
    t.decimal  "course_rating"
    t.decimal  "difficulty_rating"
    t.integer  "cusip"
    t.decimal  "cus"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "courses_queries", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "query_id"
  end

  create_table "courses_requirements", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "requirement_id"
  end

  create_table "meetings", :force => true do |t|
    t.decimal  "start_time"
    t.decimal  "end_time"
    t.integer  "day"
    t.integer  "section_id"
    t.integer  "recitation_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "queries", :force => true do |t|
    t.string   "requirement_category"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.decimal  "course_rating_lower_bound"
    t.decimal  "difficulty_rating_upper_bound"
  end

  create_table "recitations", :force => true do |t|
    t.integer  "listing"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requirements", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sections", :force => true do |t|
    t.integer  "listing"
    t.integer  "course_id"
    t.decimal  "instructor_rating"
    t.string   "instructor"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
