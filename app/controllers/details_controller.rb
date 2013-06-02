require 'trove_connector'
require 'open_calais_connector'
require 'pp'

class DetailsController < ApplicationController

  # This is an array of all the entities maps should try and map!


  TROVE = TroveConnector.new 'u6uep5gs1dh99d6u'
  OC = OpenCalaisConnector.new 'r8hxmgzrxwz85yp7trnz2yyq'

  def show
    @article = TROVE.get_article params['article']
    enriched = OC.enrich @article['articleText']
    @open_calais = OC.clean_results enriched
    puts "#Test #{@open_calais.inspect}"

    pp @open_calais
    @mapTheseEntities = ['City', 'Company', 'Continent', 'Country', 'Resolution', 'Natural Feature', 'Place', 'ProvinceOrState', 'Region', 'Company Location', 'Address', 'Geo', 'ProvinceOrState']


    @locations = []

    #TODO: fix mass map locations
    @map_locations = []

    @open_calais[:entities].each do |type, entities|

      entities.each do |entity|

        if entity['resolutions'].nil?
          e = [entity['name'].gsub("'", ""), nil, nil]
          @map_locations.push e
        else
          entity['resolutions'].each do |res|
            e = [entity['name'].gsub("'", ""), res['latitude'], res['longitude']]
            @map_locations.push e
          end
        end

        @locations.push entity['name'].gsub("'", "")
      end if !type.nil? and @mapTheseEntities.include?(type)

    end
    @map_locations = @map_locations.to_json
  end

  def get_record
    article = TROVE.get_article params[:q_article]
    enriched = OC.enrich article['articleText']
    partial = render_to_string :partial => "details/get_record", :locals => {:article => article}
    render :text => partial
  end

  def get_dbp
    dbc = DBpediaConnector.new
    @mapTheseEntities = ['City', 'Company', 'Continent', 'Country', 'Facility', 'Natural Feature', 'Organization', 'Place', 'ProvinceOrState', 'Region', 'Company Location', 'Address', 'Geo', 'ProvinceOrState']
    type = "person" if params[:type] == "Position" || params[:type] == "Person"
    type = "place" if @mapTheseEntities.include? params[:type]
    @results = dbc.query(params[:value], type)
    partial = render_to_string :partial => "details/dbp"
    render :text => partial
  end

end
