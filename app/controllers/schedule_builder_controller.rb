class ScheduleBuilderController < ApplicationController
  def show
  	@schedule = CsClass.all
  end
end
