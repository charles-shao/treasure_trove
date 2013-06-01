require 'trove_connector'
require 'pp'

class ResultsController < ApplicationController

  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'

  def index
  	if !params[:search_param].empty?
  		@search_params = params[:search_param]
  		@results = TROVE.query_articles @search_params
  	else
  		redirect_to root_path, :flash => { :error => "Search cannot be empty" }
  	end

  end
end
