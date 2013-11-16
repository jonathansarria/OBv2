class ScheduleBuilderController < ApplicationController
  def index
  	@courses = Schedule.available
    @earliest = 8
    @latest = 20
    @days_abbr = ['M', 'T', 'W', 'R', 'F']
    get_min_times
    @table_header = [#"status",
                     "crn",
                     "course",
                     #"sect",
                     #"part_term",
                     "title",
                     #"cr_hrs",
                     "beg_date",
                     "end_date",
                     #"camp",
                     "days",
                     "beg_time",
                     "end_time",
                     #"meet_type",
                     "bldg",
                     "room",
                     "seats",
                     #"waitlist",
                     #"aprv",
                     #"addl_fees",
                     "instructor"]

    @time_sel = Array.new
    (1..12).each do |i|
      @time_sel << [Time.now.change(hour: i).strftime("%0l:%M"), i]
    end

  end

  def get_min_times
    # Set minimum hour range for week table
    times = Schedule.times
    unless times[0].nil? && times[1].nil?
      if times[1].nil?
        @earliest = times[0][:first][:beg_time][/^[^:]*/].to_i
        @latest = times[0][:last][:beg_time][/^[^:]*/].to_i
      elsif times[0].nil?
        @earliest = times[1][:first][:beg_time][/^[^:]*/].to_i + 12
        @latest = times[1][:last][:beg_time][/^[^:]*/].to_i + 12
      else
        @earliest = times[0][:first][:beg_time][/^[^:]*/].to_i
        @latest = times[1][:last][:beg_time][/^[^:]*/].to_i + 12
      end
    end
  end

  def lol
    #Schedule.get_times(params)
    render text: params[:post].inspect
    #get POST
    #build sql (SELECT * FROM schedules WHERE time IN RANGE AND days IN RANGE)
    #redirect to new page with w/e partials for new week
  end


=begin
  def get_times
    cont = {am: true, pm: true}
    early = Hash.new(nil)
    late = Hash.new(nil)

    Schedule.times.each do |time|
      if time[:beg_time].match(/AM/)
        if cont[:am] || (time[:beg_time].match(/^12/))
          early[:first] = time[:beg_time]
          cont[:am] = false
        elsif !(time[:beg_time].match(/^12/))
          early[:last] = time[:beg_time]
        end
      end
      if time[:beg_time].match(/PM/) 
        if cont[:pm] || (time[:beg_time].match(/^12/))
          late[:first] = time[:beg_time]
          cont[:pm] = false
        elsif !(time[:beg_time].match(/^12/))
          late[:last] = time[:beg_time]
        end
      end
    end
      
    unless early.nil? && late.nil?
      if late.nil?
        @earliest = early[:first][/^[^:]*/].to_i
        @latest = early[:last][/^[^:]*/].to_i
      elsif early.nil?
        @earliest = late[:first][/^[^:]*/].to_i
        @latest = late[:last][/^[^:]*/].to_i
      else
        @earliest = early[:first][/^[^:]*/].to_i
        @latest = late[:last][/^[^:]*/].to_i + 12
      end
    end
  end
=end
end
