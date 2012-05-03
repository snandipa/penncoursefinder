class PagesController < ApplicationController
  def home
    @query = Query.new
  end

  def queryresult
  end

  def queryall
  end
end
