require 'test_helper'

class SectionTest < ActiveSupport::TestCase
    test "should be able to add a single meeting to a section" do
      c= Course.create(:department => "ARTH", :number => 525, :name => "DAILY LIFE/AEG. BRNZ AGE", :cusip => 32492, :cus => 1.0, :course_rating => 3.35, :difficulty_rating => 2.5)
  
      s1 = Section.create(listing:401, course_id:Course.find_by_cusip(32492).id, instructor: "E SHANK", instructor_rating: 3.64)
      t1 = Meeting.create(start_time:15.0, end_time:18.0, day:2)
      s1.meetings << t1
      
      assert s1.meetings.count == 1, "Allowed you to improperly associate a meeting with a section"
    end
end
