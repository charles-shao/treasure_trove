require 'trove_connector'

class PagesController < ApplicationController 

  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'


  def index
    puts TROVE.query_articles 'Winston'
  end

end

