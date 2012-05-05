class Querytiming < ActiveRecord::Base
  attr_accessible :desired_start_time, :desired_end_time, :desired_day

  has_and_belongs_to_many :sections

  #Each QueryNumber has a course number lower bound, course number upper bound, department category,
  validates_presence_of :desired_start_time, :desired_end_time, :desired_day
 
  after_save :associate_sections
  
  #Functions for queries
  
  #This helper function returns the current instance of the query
  def query
    self
  end
  
  def validate
     errors.add_to_base "Your start time cannot be later than your end time" if desired_start_time>desired_end_time
  end
  
    def desired_day_to_s
    case
      when desired_day == 0 then return "Sunday"  
      when desired_day == 1 then return "Monday"
      when desired_day == 2 then return "Tuesday"
      when desired_day == 3 then return "Wednesday"
      when desired_day== 4 then return "Thursday"
      when desired_day== 5 then return "Friday"
      when desired_day == 6 then return "Saturday"
      else return "Unknown Day"
    end
  end
  
  def desired_start_time_to_s #
    hr = (desired_start_time*10.0).round / 10
    min = ((desired_start_time - hr) * 60).round
    case
      when hr == 0 then return min > 0 ? "12:#{min}am" : "12:#{min}0am"
      when hr == 12 then return min > 0 ? "#{hr}:#{min}pm" : "#{hr}:#{min}0pm"
      when hr >= 12 then return min > 0 ? "#{hr % 12}:#{min}pm" : "#{hr % 12}:#{min}0pm"
      else return min > 0 ? "#{hr}:#{min}am" : "#{hr}:#{min}0am"
    end
  end
  
  def desired_end_time_to_s #
    hr = (desired_end_time*10.0).round / 10
    min = ((desired_end_time - hr) * 60).round
    case
      when hr == 0 then return min > 0 ? "12:#{min}am" : "12:#{min}0am"
      when hr == 12 then return min > 0 ? "#{hr}:#{min}pm" : "#{hr}:#{min}0pm"
      when hr >= 12 then return min > 0 ? "#{hr % 12}:#{min}pm" : "#{hr % 12}:#{min}0pm"
      else return min > 0 ? "#{hr}:#{min}am" : "#{hr}:#{min}0am"
    end
  end
  
  private
    def associate_sections

      all_sections=Section.all
      all_sections.each do |the_section|
        if the_section.has_meeting_at(self.desired_start_time, self.desired_end_time, self.desired_day)
            self.sections << the_section
        end
      end

    end
end
