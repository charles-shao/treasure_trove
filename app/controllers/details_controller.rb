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

  def get_record
    article = TROVE.get_article params[:q_article]
    enriched = OC.enrich article['articleText']
    partial = render_to_string :partial => "details/get_record", :locals => {:article => article}
    render :text => partial
  end

end
