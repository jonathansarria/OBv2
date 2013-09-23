class CreateCsClasses < ActiveRecord::Migration
  def change
    create_table :cs_classes do |t|
      t.string :Status 
      t.string :CRN
      t.string :Course
      t.string :Sect
      t.string :PartTerm
      t.string :Title
      t.string :CrHrs
      t.string :BegDate
      t.string :EndDate
      t.string :Camp
      t.string :Days
      t.string :BegTime
      t.string :End_Time
      t.string :MeetType
      t.string :Bldg
      t.string :Room
      t.string :Seats
      t.string :Waitlist
      t.string :Aprv
      t.string :AddlFees
      t.string :Instructor

      t.timestamps
    end
  end
end
