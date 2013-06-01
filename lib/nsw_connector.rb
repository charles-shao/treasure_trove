class NSWConnector

  include HTTParty

  base_uri 'http://search.records.nsw.gov.au/'
  format :json

  DEFAULT_OPTIONS = {'content-type' => 'text/html', 'outputformat' => 'application/json'}

  def initialize()

  end


  def get_results(term)
    response = query(term)
  end

  def query(term)
    options[:q] = URI::escape(term)
    response = self.class.get('/search.json', query: options)
    response.parsed_response
  end

end