class QuerytimingsController < ApplicationController
  def new
    @querytiming  = Querytiming.new
    @start_meetings = Array.new
    (16..36).to_a.each do |the_start_time|
      @start_meetings << Meeting.new(:start_time => the_start_time/2.0, :end_time => the_start_time/2.0 + 1.0, :day => 3)
    end
    
    @end_meetings = Array.new
    (16..36).to_a.each do |the_end_time|
      @end_meetings << Meeting.new(:start_time => the_end_time/2.0, :end_time => the_end_time/2.0 + 1.0, :day => 3)
    end
    
    @day_meetings = Array.new
    (1..5).to_a.each do |the_day|
      @day_meetings << Meeting.new(:start_time => 6, :end_time => 7, :day => the_day)
    end
  end
  
  def create
    @querytiming = Querytiming.new(params[:querytiming])
    if @querytiming.save
      redirect_to @querytiming, :flash => { :success => "Your query has been processed!" }
    else
      render 'new'
    end
  end

  def destroy
    @querytiming.destroy
  end

  def show
    @querytiming = Querytiming.find(params[:id])
    @querytimings = @querytiming.sections.paginate(:page => params[:page], :per_page => 20)
  end

  def index
    @querytimings = Querytiming.paginate(:page => params[:page])
  end
end
