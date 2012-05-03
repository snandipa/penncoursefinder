class CoursesController < ApplicationController
  def edit
  end

  def index
    @courses = Course.paginate(:page => params[:page])
    @title = "All Courses"
  end

  def show
    @course = Course.find(params[:id])
    @title = @course.name
  end

  def new
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
    else
    end
  end
  
  def destroy
    @course.destroy
  end

end
