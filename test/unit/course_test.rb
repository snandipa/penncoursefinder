require 'test_helper'

class CourseTest < ActiveSupport::TestCase
   test "should not allow you to create two courses with same number in one department" do
     original_course = Course.create(department:"CIS", number:95, cusip:10320, name:"Test CIS Class", cus:1, course_rating:2.5, difficulty_rating:2.5)
     new_course = Course.new(department:"CIS", number:95, cusip:10321, name:"Test CIS Class 2", cus:1, course_rating:2.5, difficulty_rating:2.5)
     
     assert !new_course.save, "Allowed you to create two courses with same number in same department"
   end
   
    test "should always contain a department" do
     the_course = Course.create(number:95, cusip:10320, name:"Test CIS Class", cus:1, course_rating:2.5, difficulty_rating:2.5)
     assert !the_course.save, "Allowed you to save a course without a department"
    end
    
    test "should always contain a number" do
     the_course = Course.create(department:"CIS", cusip:10320, name:"Test CIS Class", cus:1, course_rating:2.5, difficulty_rating:2.5)
     assert !the_course.save, "Allowed you to save a course without a number"
   end
    
    test "should always contain a name" do
     the_course = Course.create(department:"CIS", number:95, cusip:10320, cus:1, course_rating:2.5, difficulty_rating:2.5)
     assert !the_course.save, "Allowed you to save a course without a number"
    end
    

end
