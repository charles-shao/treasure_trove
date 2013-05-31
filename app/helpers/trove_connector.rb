class TroveConnector
 
  include HTTParty
 
  base_uri 'api.trove.nla.gov.au'
  format :json
 
  QUERY_DEFAULT_OPTIONS = {encoding: 'json', zone: 'newspaper'}
  RECORD_DEFAULT_OPTIONS = {encoding: 'json', reclevel: 'full', include: 'all'}
 
  def initialize(api_key)
    QUERY_DEFAULT_OPTIONS[:key] = api_key
    RECORD_DEFAULT_OPTIONS[:key] = api_key
  end
 
  def query_articles(term, options={})
    response = query_records(term, options)
    response['response']['zone'][0]['records']['article']
  end
 
  def query_records(term, options={})
    parameters = QUERY_DEFAULT_OPTIONS.merge options
    parameters[:q] = URI::escape(term)
    response = self.class.get('/result', query: parameters)
    response.parsed_response
  end
 
  def get_article(record_url, options={})
    response = get_record(record_url, options)
    response['article']
  end
 
  def get_record(record_url, options={})
    parameters = RECORD_DEFAULT_OPTIONS.merge options
    response = self.class.get(record_url, query: parameters)
    response.parsed_response
  end
 
end