require 'trove_connector'
require 'pp'

class ResultsController < ApplicationController

  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'

  def index
  	@search_params = params[:search_param]
  	@results = TROVE.query_articles @search_params

  end
end
