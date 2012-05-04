class Query < ActiveRecord::Base
  #The accessible attributes are the attributes that can be accessed within the Controller
  attr_accessible :course_rating_lower_bound, :difficulty_rating_upper_bound, :requirement_category

  has_and_belongs_to_many :courses

  #Each Query has a course rating lower bound, difficulty rating upper bound, requirement category,
  validates_presence_of :course_rating_lower_bound, :difficulty_rating_upper_bound, :requirement_category
 
  after_save :associate_courses
  
  #Functions for queries
  def some_function

  end
  
  def course_rating_lower_bound_to_s
    return course_rating_lower_bound.round(2).to_s
  end
  
  def difficulty_rating_upper_bound_to_s
    return difficulty_rating_upper_bound.round(2).to_s
  end
  
  #This helper function returns the current instance of the query
  def query
    self
  end
  
  private
    def associate_courses

      all_courses=Course.all
      all_courses.each do |the_course|
        if the_course.course_rating > self.course_rating_lower_bound && the_course.difficulty_rating < self.difficulty_rating_upper_bound
          if !(the_course.requirements.empty?) && the_course.requirements[0].category == self.requirement_category
            self.courses << the_course
          end
        end
      end

    end
    
end
