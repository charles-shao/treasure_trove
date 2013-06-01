class ResultsController < ApplicationController
  def index
  	@search_params = params[:search_param]
  	puts @search_params
  end
end
