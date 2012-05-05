require 'test_helper'

class CourseTest < ActiveSupport::TestCase
   test "should not allow you to create two courses with same number in one department" do
     original_course = Course.create(department:"CIS", number:95, cusip:10320, name:"Test CIS Class", cus:1, course_rating:2.5, difficulty_rating:2.5)
     new_course = Course.new(department:"CIS", number:95, cusip:10321, name:"Test CIS Class 2", cus:1, course_rating:2.5, difficulty_rating:2.5)
     
     assert !new_course.save?, "Allowed you to create two courses with same number in same department"
   end
end
