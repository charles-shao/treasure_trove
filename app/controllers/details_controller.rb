require 'trove_connector'
require 'pp'

class DetailsController < ApplicationController

  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'

  def show
    @article = TROVE.get_article params['article']
    pp @article
  end
end
