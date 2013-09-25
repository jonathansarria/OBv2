class ScheduleBuilderController < ApplicationController
  def index
  	@courses = Schedule.available
  end
end
