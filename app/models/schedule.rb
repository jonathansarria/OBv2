class Schedule < ActiveRecord::Base
  def Schedule.available
    self.select("title, course, beg_time, end_time").where.not(status: ["Closed", "Cancelled"])
  end
end
