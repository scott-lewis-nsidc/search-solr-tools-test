require_relative './selectors/helpers/iso_to_solr'
require_relative './oai_harvester'
require_relative './selectors/helpers/query_builder'
require_relative './selectors/helpers/iso_namespaces'

# Harvests data from CISL and inserts it into Solr after it has been translated
class CislHarvester < OaiHarvester
  def initialize(env = 'development', die_on_failure = false)
    super
    @data_centers = SolrFormat::DATA_CENTER_NAMES[:CISL][:long_name]
    @translator = IsoToSolr.new :cisl

    # Used in query string params, resumptionToken
    @dataset = '0bdd2d39-3493-4fa2-98f9-6766596bdc50'
  end

  def metadata_url
    SolrEnvironments[@environment][:cisl_url]
  end

  def results
    list_records_oai_response = get_results(request_string, '//oai:ListRecords', '')

    @resumption_token = list_records_oai_response.xpath('.//oai:resumptionToken', IsoNamespaces.namespaces)
    @resumption_token = format_resumption_token(@resumption_token.first.text)

    list_records_oai_response.xpath('.//oai:record', IsoNamespaces.namespaces)
  end

  private

  def request_params
    {
      verb: 'ListRecords',
      metadataPrefix: 'dif',
      set: @dataset,
      resumptionToken: @resumption_token
    }.delete_if { |_k, v| v.nil? }
  end

  # The ruby response is lacking quotes, which the token requires in order to work...
  # Also, the response back seems to be inconsistent - sometimes it adds &quot; instead of '"',
  # which makes the token fail to work.
  # To get around this I'd prefer to make assumptions about the token and let it break if
  # they change the formatting.  For now, all fields other than offset should be able to be
  # assumed to remain constant.
  # If the input is empty, then we are done - return an empty string, which is checked for
  # in the harvest loop.
  def format_resumption_token(resumption_token)
    return '' if resumption_token.empty?

    resumption_token =~ /offset:(\d+)/
    offset = Regexp.last_match(1)

    {
      from: nil,
      until: nil,
      set: @dataset,
      metadataPrefix: 'dif',
      offset: offset
    }.to_json
  end
end
