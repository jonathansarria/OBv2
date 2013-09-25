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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130925042817) do

  create_table "schedules", force: true do |t|
    t.string   "status"
    t.string   "crn"
    t.string   "course"
    t.string   "sect"
    t.string   "part_term"
    t.string   "title"
    t.string   "cr_hrs"
    t.string   "beg_date"
    t.string   "end_date"
    t.string   "camp"
    t.string   "days"
    t.string   "beg_time"
    t.string   "end_time"
    t.string   "meet_type"
    t.string   "bldg"
    t.string   "room"
    t.string   "seats"
    t.string   "waitlist"
    t.string   "aprv"
    t.string   "addl_fees"
    t.string   "instructor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
