class Course < ActiveRecord::Base
  #The accessible attributes are the attributes that can be accessed within the Controller
  attr_accessible :department, :number, :cusip, :name, :cus, :course_rating, :difficulty_rating
  
  #Each Course has many sections and has many recitations. If a course is destroyed, the associated sections and recitations are also destroyed
  has_many :sections, :dependent => :destroy
  has_many :recitations, :dependent => :destroy

  #Each Course could satisfy a particular requirement (such as Humanities) and each requirement has many associated courses with it
  has_and_belongs_to_many :requirements
  
  has_and_belongs_to_many :queries
  has_and_belongs_to_many :querynumbers

  #When creating a course, the department, number, unique identifier, name, course units, course rating and difficulty rating fields must all have data
  validates_presence_of :department, :number, :cusip, :name, :cus, :course_rating, :difficulty_rating
  
  #Within a certain department (such as ESE), there can only be one particular number. For example, there is only one 451 within ESE
  validates_uniqueness_of :number, :scope => :department
  
  #This function converts the course number into a format more accessible to students
  def number_to_s
    case
      when number < 10 then return "00#{number}"
      when number < 100 then return "0#{number}"
      else return "#{number}"
    end
  end
  
  def course_rating_to_s
    return course_rating.round(2).to_s
  end
  
  def difficulty_rating_to_s
    return difficulty_rating.round(2).to_s
  end
  
  #This function returns the title of the course, specified with the fields shown
  def title
    return "#{department} #{number_to_s} - #{name}"
  end
  
  #This helper function returns the current instance of the course
  def course
    self
  end
  
end
