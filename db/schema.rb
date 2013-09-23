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

ActiveRecord::Schema.define(version: 20130923011912) do

  create_table "cs_classes", force: true do |t|
    t.string   "Status"
    t.string   "CRN"
    t.string   "Course"
    t.string   "Sect"
    t.string   "PartTerm"
    t.string   "Title"
    t.string   "CrHrs"
    t.string   "BegDate"
    t.string   "EndDate"
    t.string   "Camp"
    t.string   "Days"
    t.string   "BegTime"
    t.string   "End_Time"
    t.string   "MeetType"
    t.string   "Bldg"
    t.string   "Room"
    t.string   "Seats"
    t.string   "Waitlist"
    t.string   "Aprv"
    t.string   "AddlFees"
    t.string   "Instructor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
