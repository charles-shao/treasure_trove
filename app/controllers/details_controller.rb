require 'trove_connector'
require 'open_calais_connector'
require 'pp'

class DetailsController < ApplicationController

  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'
  OC = OpenCalaisConnector.new 'r8hxmgzrxwz85yp7trnz2yyq'

  def show
    @article = TROVE.get_article params['article']
    enriched = OC.enrich @article['articleText']
    @open_calais = OC.clean_results enriched
  end
end
