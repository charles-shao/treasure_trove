class OpenCalaisConnector
 
  include HTTParty
 
  base_uri 'api.opencalais.com'
  format :json
 
  DEFAULT_OPTIONS = {'content-type' => 'text/html', 'outputformat' => 'application/json'}
 
  def initialize(api_key)
    DEFAULT_OPTIONS['x-calais-licenseID'] = api_key
  end
 
  def enrich(text, options={})
    headers = DEFAULT_OPTIONS.merge options
    response = self.class.post('/tag/rs/enrich', headers: headers, body: text)
    response.parsed_response
  end
 
end