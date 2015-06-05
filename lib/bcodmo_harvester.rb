require 'nokogiri'
require 'rest-client'
require './lib/harvester_base'
require './lib/selectors/bcodmo_json_to_solr'
require 'json'
require './lib/selectors/helpers/iso_to_solr_format'
require './lib/selectors/helpers/facet_configuration'

# Harvests data from BcoDmo endpoint, translates and adds it to solr
class BcoDmoHarvester < HarvesterBase
  def initialize(env = 'development', die_on_failure = false)
    super env, die_on_failure
    @translator = BcodmoJsonToSolr.new
    @wkt_parser = RGeo::WKRep::WKTParser.new(nil, {})   # (factory_generator_=nil,
  end

  def harvest_and_delete
    # TODO: add long name for deletion
    super(method(:harvest_bcodmo_into_solr), "data_centers:\"#{SolrFormat::DATA_CENTER_NAMES[:BCODMO][:long_name]}\"")
  end

  def harvest_bcodmo_into_solr
    result = translate_bcodmo
    insert_solr_docs result[:add_docs], HarvesterBase::JSON_CONTENT_TYPE
    fail 'Failed to harvest some records from the provider' if result[:failure_ids].length > 0
  end

  def translate_bcodmo
    documents = []
    failure_ids = []
    request_json(SolrEnvironments[@environment][:bcodmo_url]).each do |record|
      geometry = request_json(record['geometryUrl'])
      results = parse_record(record, geometry)
      results[:documents].each { |d| documents << d }
      results[:failure_ids].each { |id| failure_ids << id }
    end
    { add_docs: documents, failure_ids: failure_ids }
  end

  def request_json(url)
    JSON.parse(RestClient.get(url))
  end

  def parse_record(record, geometry)
    documents = []
    failure_ids = []
    begin
      JSON.parse(RestClient.get(record['datasets'])).each do |dataset|
        documents << { 'add' => { 'doc' => @translator.translate(dataset, record, geometry) } }
      end
    rescue => e
      puts "Failed to add record #{record['id']} with error #{e} (#{e.message}) : #{e.backtrace.join("\n")}"
      failure_ids << record['id']
    end
    { documents: documents, failure_ids: failure_ids }
  end
end
