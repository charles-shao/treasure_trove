class DBpediaConnector
 
  include HTTParty
 
  base_uri 'lookup.dbpedia.org'
  format :json
 
 
  DEFAULT_OPTIONS = {:MaxHits => 1}
  HEADERS = {'Accept' => 'application/json'}
 
  def get_entry(term, entity_type=nil)
    response = query(term, entity_type)
    response['results'][0]
  end
 
  def query(term, entity_type=nil)
    options[:QueryString] = URI::escape(term)
    if entity_type
      options[:QueryClass] = entity_type
    end
    response = self.class.get('/api/search/KeywordSearch', query: options, headers: HEADERS)
    response.parsed_response
  end
 
end