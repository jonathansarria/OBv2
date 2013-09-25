class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :status 
      t.string :crn
      t.string :course
      t.string :sect
      t.string :part_term
      t.string :title
      t.string :cr_hrs
      t.string :beg_date
      t.string :end_date
      t.string :camp
      t.string :days
      t.string :beg_time
      t.string :end_time
      t.string :meet_type
      t.string :bldg
      t.string :room
      t.string :seats
      t.string :waitlist
      t.string :aprv
      t.string :addl_fees
      t.string :instructor

      t.timestamps
    end
  end
end
