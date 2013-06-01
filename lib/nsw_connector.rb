class NSWConnector

  include HTTParty

  base_uri 'http://search.records.nsw.gov.au/'
  format :xml

  DEFAULT_OPTIONS = {'content-type' => 'text/html', 'outputformat' => 'text/xml'}

  def query(term)
    options = {}
    options[:q] = URI::escape(term)
    response = self.class.get('/search.xml?' , query: options)
    response.parsed_response
  end

end