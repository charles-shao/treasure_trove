class OpenCalaisConnector
 
  include HTTParty
 
  base_uri 'api.opencalais.com'
  format :json
 
  TEST = {ter: {"_typeGroup"=>"relations",
 "_type"=>"PersonCommunication",
 "persondescription"=>"East  Germans",
 "status"=>"announced",
 "_typeReference"=>"http://s.opencalais.com/1/type/em/r/PersonCommunication",
 "instances"=>
  [{"detection"=>
     "[ several  times  a  week  and   a  total  of  ]51  East  Germans   met[  their  death  while  trying   to ]",
    "prefix"=>" several  times  a  week  and   a  total  of  ",
    "exact"=>"51  East  Germans   met",
    "suffix"=>"  their  death  while  trying   to ",
    "offset"=>2327,
    "length"=>23}]}}

  DEFAULT_OPTIONS = {'content-type' => 'text/html', 'outputformat' => 'application/json'}
 
  def initialize(api_key)
    DEFAULT_OPTIONS['x-calais-licenseID'] = api_key
  end
 
  def enrich(text, options={})
    headers = DEFAULT_OPTIONS.merge options
    response = self.class.post('/tag/rs/enrich', headers: headers, body: text)
    response.parsed_response
  end
 

  def clean_results(results)
    cleaned = {entities: {}, relations: {}}
    results.each_value do |value|
      if value.key? '_typeGroup'
        group = value['_typeGroup']
        if group == 'entities'
          clean_entities(value, cleaned)
        elsif group == 'relations'
          clean_relations(value, cleaned)
        end
      end
    end
    cleaned
  end


  def clean_entities(entity_hash, cleaned)
    type = entity_hash['_type']
    subset = entity_hash.except('_typeGroup', '_type')
    if cleaned[:entities].key? type
      cleaned[:entities][type] << subset
    else
      cleaned[:entities][type] = [subset]
    end
  end


  def clean_relations(relation_hash, cleaned)
    type = relation_hash['_type']
    subset = relation_hash.except('_typeGroup', '_type')
    if cleaned.key? type
      cleaned[:relations][type] << subset
    else
      cleaned[:relations][type] = [subset]
    end
  end

end