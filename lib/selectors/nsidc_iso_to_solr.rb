require './lib/selectors/iso_to_solr_format'
require './lib/selectors/solr_string_format'

# The hash contains keys that should map to the fields in the solr schema, the keys are called selectors
# and are in charge of selecting the nodes from the ISO document, applying the default value if none of the
# xpaths resolved to a value and formatting the field.
# xpaths and multivalue are required, default_value and format are optional

long_name = 'National Snow and Ice Data Center'
short_name = 'NSIDC'

NSIDC = {
  authoritative_id: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString'],
    multivalue: false
  },
  dataset_version: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:edition/gco:CharacterString'],
    multivalue: false
  },
  title: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString'],
    multivalue: false
  },
  summary: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString'],
    multivalue: false
  },
  data_centers: {
      xpaths: [''],
      default_values: [long_name],
      multivalue: false
    },
  authors: {
    xpaths: ['.//gmd:CI_ResponsibleParty[.//gmd:CI_RoleCode="principalInvestigator"]//gmd:individualName[not(contains(gco:CharacterString, "NSIDC User Services"))]
              | .//gmd:CI_ResponsibleParty[.//gmd:CI_RoleCode="author"]//gmd:individualName[not(contains(gco:CharacterString, "NSIDC User Services"))]
              | .//gmd:CI_ResponsibleParty[.//gmd:CI_RoleCode="metadata author"]//gmd:individualName[not(contains(gco:CharacterString, "NSIDC User Services"))]'],
    multivalue: true,
    unique: true
  },
  topics: {
    xpaths: ['.//gmd:MD_TopicCategoryCode'],
    multivalue: true
  },
  keywords: {
    xpaths: ['.//gmd:MD_Keywords[.//gmd:MD_KeywordTypeCode="theme" and not(.//gmd:thesaurusName)]//gmd:keyword/gco:CharacterString'],
    multivalue: true
  },
  parameters: {
    xpaths: ['.//gmd:MD_Keywords[.//gmd:MD_KeywordTypeCode="discipline"]//gmd:keyword/gco:CharacterString'],
    multivalue: true,
    format: proc { |param| param.text.split ' > ' }
  },
  full_parameters: {
    xpaths: ['.//gmd:MD_Keywords[.//gmd:MD_KeywordTypeCode="discipline"]//gmd:keyword/gco:CharacterString'],
    multivalue: true
  },
  platforms: {
    xpaths: ['.//gmi:MI_Platform/gmi:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString'],
    multivalue: true
  },
  sensors: {
    xpaths: ['.//gmi:MI_Instrument/gmi:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString'],
    multivalue: true
  },
  brokered: {
    xpaths: ['.//gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource[gmd:CI_OnLineFunctionCode="offlineAccess"]'],
    multivalue: false,
    format: proc { |offline| offline.is_a?(Nokogiri::XML::Node) ? 'true' : 'false' }
  },
  published_date: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date'],
    multivalue: false,
    format: SolrStringFormat::DATE
  },
  spatial_coverages: {
    xpaths: ['.//gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    format: IsoToSolrFormat::SPATIAL_DISPLAY
  },
  spatial: {
    xpaths: ['.//gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    format: IsoToSolrFormat::SPATIAL_INDEX
  },
  spatial_area: {
    xpaths: ['.//gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    reduce: IsoToSolrFormat::MAX_SPATIAL_AREA,
    format: IsoToSolrFormat::SPATIAL_AREA
  },
  temporal_coverages: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    multivalue: true,
    format: IsoToSolrFormat::TEMPORAL_DISPLAY_STRING
  },
  temporal_duration: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    multivalue: false,
    reduce: SolrStringFormat::REDUCE_TEMPORAL_DURATION,
    format: IsoToSolrFormat::TEMPORAL_DURATION_FROM_XML
  },
  temporal: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    multivalue: true,
    format: IsoToSolrFormat::TEMPORAL_INDEX_STRING
  },
  last_revision_date: {
    xpaths: ['.//gmd:dateStamp/gco:Date'],
    multivalue: false,
    format: SolrStringFormat::DATE
  },
  dataset_url: {
    xpaths: ['.//gmd:dataSetURI'],
    multivalue: false
  },
  distribution_formats: {
    xpaths: ['.//gmd:MD_Format/gmd:name/gco:CharacterString'],
    multivalue: true
  },
  popularity: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceSpecificUsage/gmd:MD_Usage/gmd:popularity/gco:Integer'],
    multivalue: false
  },
  source: {
    xpaths: [''],
    default_values: %w(NSIDC ADE),
    multivalue: true
  },
  facet_data_center: {
      xpaths: [''],
      default_values: ["#{long_name} | #{short_name}"],
      multivalue: true
  },
  facet_spatial_coverage: {
    xpaths: ['.//gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    format: IsoToSolrFormat::FACET_SPATIAL_COVERAGE
  },
  facet_spatial_scope: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    format: IsoToSolrFormat::FACET_SPATIAL_SCOPE
  },
  facet_temporal_duration: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    default_values: ['No Temporal Information'],
    format: IsoToSolrFormat::FACET_TEMPORAL_DURATION_FROM_XML,
    multivalue: true
  },
  facet_format: {
    xpaths: ['.//gmd:distributionFormat/gmd:MD_Format/gmd:name/gco:CharacterString'],
    default_values: ['Not specified'],
    multivalue: true,
    format: SolrStringFormat::FORMAT_BINNING
  },
  facet_parameter: {
    xpaths: ['.//gmd:MD_Keywords[.//gmd:MD_KeywordTypeCode="discipline"]//gmd:keyword/gco:CharacterString'],
    multivalue: true,
    format: SolrStringFormat::PARAMETER_BINNING
  },
  facet_sponsored_program: {
    xpaths: ['.//gmd:pointOfContact/gmd:CI_ResponsibleParty[.//gmd:CI_RoleCode="custodian"]'],
    multivalue: true,
    format: IsoToSolrFormat::FACET_SPONSORED_PROGRAM
  }
}
