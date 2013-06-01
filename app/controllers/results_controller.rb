require 'trove_connector'
require 'open_calais_connector'
require 'pp'

class ResultsController < ApplicationController

  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'
  OC = OpenCalaisConnector.new 'r8hxmgzrxwz85yp7trnz2yyq'

  def index
  	@search_params = params[:search_param]
  	@results = TROVE.query_articles @search_params
    pp @results
  end
end
