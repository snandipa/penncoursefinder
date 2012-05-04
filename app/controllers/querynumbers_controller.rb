class QuerynumbersController < ApplicationController
  def new
    @querynumber  = Querynumber.new
  end
  
  def create
    @querynumber = Querynumber.new(params[:querynumber])
    if @querynumber.save
      redirect_to @querynumber, :flash => { :success => "Your query has been processed!" }
    else
      render 'new'
    end
  end

  def destroy
    @querynumber.destroy
  end

  def show
    @querynumber = Querynumber.find(params[:id])
    @querynumbers = @querynumber.courses.paginate(:page => params[:page], :per_page => 20)
  end

  def index
    @querynumbers = Querynumber.paginate(:page => params[:page])
  end
end
