class Querynumber < ActiveRecord::Base
  attr_accessible :course_number_lower_bound, :course_number_upper_bound, :department

  has_and_belongs_to_many :courses

  #Each QueryNumber has a course number lower bound, course number upper bound, department category,
  validates_presence_of :course_number_lower_bound, :course_number_upper_bound, :department
 
  after_save :associate_courses
  
  #Functions for queries
  def department_to_s
    return department.upcase
  end
  
  #This helper function returns the current instance of the query
  def query
    self
  end
  
  private
    def associate_courses
      self.department = self.department.upcase
      
      all_courses=Course.all
      all_courses.each do |the_course|
        if the_course.department == self.department && the_course.number > self.course_number_lower_bound && the_course.number < self.course_number_upper_bound
            self.courses << the_course
        end
      end

    end
    
end
