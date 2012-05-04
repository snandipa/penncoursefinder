class QueriesController < ApplicationController
  def new
    @query  = Query.new
  end
  
  def create
    @query = Query.new(params[:query])
    if @query.save
      redirect_to @query, :flash => { :success => "Your query has been processed!" }
    else
      render 'new'
    end
  end

  def destroy
    @query.destroy
  end

  def show
    @query = Query.find(params[:id])
    @queries = @query.courses.paginate(:page => params[:page], :per_page => 20)
  end

  def index
    @queries = Query.paginate(:page => params[:page])
  end
end
