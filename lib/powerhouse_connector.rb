class PowerhouseConnector
 
  include HTTParty

  base_uri 'api.powerhousemuseum.com'
  @api_key = ''
  format :json

  HEADERS = {'Accept' => 'application/json'}

  def initialize(api_key)
      @api_key = api_key
  end


  def query(term, searchKey)

    p @api_key
    #'api_key' => @api_key,
    option = {searchKey => term}
    p option
    response = self.class.get("/api/v1/item/json/?api_key=#{@api_key}", option: option, headers: HEADERS)
    p response
  end
 
end