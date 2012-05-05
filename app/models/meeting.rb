class Meeting < ActiveRecord::Base
  attr_accessible :start_time, :end_time, :day, :section_id, :recitation_id

  belongs_to :section
  belongs_to :recitation

  validates_presence_of :start_time, :end_time, :day

  def meets_desired_time_and_day(desired_start_time, desired_end_time, desired_day)
      return true if self.start_time == desired_start_time && self.end_time == desired_end_time && self.day == desired_day
      return false
  end
  
  def day_to_s
    case
      when day == 0 then return "Sunday"  
      when day == 1 then return "Monday"
      when day == 2 then return "Tuesday"
      when day == 3 then return "Wednesday"
      when day == 4 then return "Thursday"
      when day == 5 then return "Friday"
      when day == 6 then return "Saturday"
      else return "Unknown Day"
    end
  end
  
  def start_time_to_s #
    hr = (start_time*10.0).round / 10
    min = ((start_time - hr) * 60).round
    case
      when hr == 0 then return min > 0 ? "12:#{min}am" : "12:#{min}0am"
      when hr == 12 then return min > 0 ? "#{hr}:#{min}pm" : "#{hr}:#{min}0pm"
      when hr >= 12 then return min > 0 ? "#{hr % 12}:#{min}pm" : "#{hr % 12}:#{min}0pm"
      else return min > 0 ? "#{hr}:#{min}am" : "#{hr}:#{min}0am"
    end
  end
  
  def end_time_to_s #
    hr = (end_time*10.0).round / 10
    min = ((end_time - hr) * 60).round
    case
      when hr == 0 then return min > 0 ? "12:#{min}am" : "12:#{min}0am"
      when hr == 12 then return min > 0 ? "#{hr}:#{min}pm" : "#{hr}:#{min}0pm"
      when hr >= 12 then return min > 0 ? "#{hr % 12}:#{min}pm" : "#{hr % 12}:#{min}0pm"
      else return min > 0 ? "#{hr}:#{min}am" : "#{hr}:#{min}0am"
    end
  end

end
