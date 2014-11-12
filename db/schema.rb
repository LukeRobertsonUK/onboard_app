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

ActiveRecord::Schema.define(:version => 20141112162446) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "duedil_co_url"
    t.string   "duedil_locale"
    t.date     "incorporation_date"
    t.string   "reg_co_num"
    t.string   "reg_address1"
    t.string   "reg_address2"
    t.string   "reg_address3"
    t.string   "reg_address4"
    t.string   "reg_address_postcode"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.string   "currency"
    t.string   "employee_count"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "turnover",             :limit => 8
    t.integer  "shareholders_funds",   :limit => 8
  end

  create_table "directors", :force => true do |t|
    t.string   "forename"
    t.string   "surname"
    t.date     "date_of_birth"
    t.string   "duedil_id"
    t.string   "duedil_director_url"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "directorships", :force => true do |t|
    t.integer  "director_id"
    t.integer  "company_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "duedil_id"
    t.boolean  "active"
    t.string   "status"
    t.string   "appointment_date"
    t.string   "function"
    t.string   "position"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "address4"
    t.string   "address5"
    t.string   "postcode"
  end

  add_index "directorships", ["company_id"], :name => "index_directorships_on_company_id"
  add_index "directorships", ["director_id"], :name => "index_directorships_on_director_id"

end
