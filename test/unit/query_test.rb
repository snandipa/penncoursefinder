require 'test_helper'

class QueryTest < ActiveSupport::TestCase
    test "should contain any courses that agree with boundary constraints" do
     c= Course.create(:department => "ENGL", :number => 16, :name => "GOSPEL MUSIC", :cusip => 32516, :cus => 1.0, :course_rating => 2.61, :difficulty_rating => 2.1)

      s1 = Section.create(listing:402, course_id:Course.find_by_cusip(32516).id, instructor: "C MULLER", instructor_rating: 2.92)
      t1 = Meeting.create(start_time:10.5, end_time:12.0, day:2)
      t2 = Meeting.create(start_time:10.5, end_time:12.0, day:4)
      s1.meetings << t1 << t2
      
      Requirement.create(category:"H", name:"Humanities")
      c.sections << s1
      r = Requirement.find_by_category("H")
      r.courses << c
      r.save
           
     the_query = Query.create(course_rating_lower_bound:0, difficulty_rating_upper_bound:4.0, requirement_category:"H")
     assert the_query.courses.count > 0, "Didn't find any Humanities classes, which should not happen"
    end
    
    test "should not contain any courses that violate lower boundary" do
          c= Course.create(:department => "ENGL", :number => 16, :name => "GOSPEL MUSIC", :cusip => 32516, :cus => 1.0, :course_rating => 2.61, :difficulty_rating => 2.1)

      s1 = Section.create(listing:402, course_id:Course.find_by_cusip(32516).id, instructor: "C MULLER", instructor_rating: 2.92)
      t1 = Meeting.create(start_time:10.5, end_time:12.0, day:2)
      t2 = Meeting.create(start_time:10.5, end_time:12.0, day:4)
      s1.meetings << t1 << t2
      
      Requirement.create(category:"H", name:"Humanities")
      c.sections << s1
      r = Requirement.find_by_category("H")
      r.courses << c
      r.save
     
     the_query = Query.create(course_rating_lower_bound:4.1, difficulty_rating_upper_bound:4.0, requirement_category:"H")
     assert the_query.courses.count ==0, "Somehow created a legitimate query where none should exist"
    end
    
    test "should not contain any courses that violate upper boundary" do
          c= Course.create(:department => "ENGL", :number => 16, :name => "GOSPEL MUSIC", :cusip => 32516, :cus => 1.0, :course_rating => 2.61, :difficulty_rating => 2.1)

      s1 = Section.create(listing:402, course_id:Course.find_by_cusip(32516).id, instructor: "C MULLER", instructor_rating: 2.92)
      t1 = Meeting.create(start_time:10.5, end_time:12.0, day:2)
      t2 = Meeting.create(start_time:10.5, end_time:12.0, day:4)
      s1.meetings << t1 << t2
      
      Requirement.create(category:"H", name:"Humanities")
      c.sections << s1
      r = Requirement.find_by_category("H")
      r.courses << c
      r.save
     
     the_query = Query.create(course_rating_lower_bound:0, difficulty_rating_upper_bound:0, requirement_category:"H")
     assert the_query.courses.count == 0, "Somehow created a legitimate query where none should exist"
    end
end
