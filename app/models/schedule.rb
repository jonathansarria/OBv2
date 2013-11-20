class Schedule < ActiveRecord::Base
  def Schedule.available
    self.where.not(status: ["Closed", "Cancelled"]).order(:title)
  end

  def Schedule.available_refined(courses)
    self.where(crn: courses)
  end

  def Schedule.times
    earliest = Hash.new(nil)
    latest = Hash.new(nil)

    stmnt = self.select(:beg_time).where('beg_time LIKE "%AM"').order(:beg_time)
    if self.where('beg_time LIKE "12%AM"').any?
      earliest[:first] = stmnt.where('beg_time LIKE "12%"').first
      earliest[:last] = stmnt.where('NOT (beg_time LIKE "12%")').last
    else
      earliest[:first] = stmnt.first
      earliest[:last] = stmnt.last
    end
    
    stmnt = self.select(:beg_time).where('beg_time LIKE "%PM"').order(:beg_time)
    if self.where('beg_time LIKE "12%PM"').any?
      latest[:first] = stmnt.where('beg_time LIKE "12%"').first
      latest[:last] = stmnt.where('NOT (beg_time LIKE "12%")').last
    else
      latest[:first] = stmnt.first
      latest[:last] = stmnt.last
    end
    
    return [earliest, latest]
  end

  def Schedule.get_times(params)
    puts params
  end
end
