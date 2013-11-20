class ScheduleBuilderController < ApplicationController
  def index
    @init = true
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
    @course_selection = []
    
    selection = []
    @courses.each do |course|
      @table_header.each do |attr|
        selection.push(course.send(attr))
      end
      @course_selection.push([selection.join(" "), course.crn])
      selection = []
    end

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

  def week
    @init = false
    #Schedule.get_week(params[:post][:courses])
    #render text: params[:post].inspect
    index
    @courses = Schedule.available_refined(params[:post][:courses][1..-1])
    #get_min_times
    render :index
  end

end
