require './lib/selectors/iso_to_solr_format'

# The hash contains keys that should map to the fields in the solr schema, the keys are called selectors
# and are in charge of selecting the nodes from the ISO document, applying the default value if none of the
# xpaths resolved to a value and formatting the field.
# xpaths and multivalue are required, default_value and format are optional

long_name = 'International Council for the Exploration of the Sea (ICES)'
short_name = 'ICES'

ICES = {
  authoritative_id: {
    xpaths: ['.//gmd:fileIdentifier/gco:CharacterString'],
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
    xpaths: [".//gmd:CI_ResponsibleParty[./gmd:role/gmd:CI_RoleCode[@codeListValue='principalInvestigator']]/gmd:individualName/gco:CharacterString"],
    multivalue: true
  },
  keywords: {
    xpaths: ['.//gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gco:CharacterString',
             './/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gmx:Anchor'],
    multivalue: true
  },
  last_revision_date: {
    xpaths: ['.//gmd:dateStamp/gco:Date', './/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:DateTime'],
    default_values: [IsoToSolrFormat.date_str(DateTime.now)], # formats the date into ISO8601 as in http://lucene.apache.org/solr/4_4_0/solr-core/org/apache/solr/schema/DateField.html
    multivalue: false,
    format: IsoToSolrFormat::DATE
  },
  dataset_url: {
    xpaths: ['.//gmd:fileIdentifier/gco:CharacterString'],
    multivalue: false,
    format: proc { |node| IsoToSolrFormat.ices_dataset_url(node) }
  },
  spatial_coverages: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    format: IsoToSolrFormat::SPATIAL_DISPLAY
  },
  spatial: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox'],
    multivalue: true,
    format: IsoToSolrFormat::SPATIAL_INDEX
  },
  spatial_area: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox'],
    multivalue: false,
    reduce: IsoToSolrFormat::MAX_SPATIAL_AREA,
    format: IsoToSolrFormat::SPATIAL_AREA
  },
  temporal_coverages: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    multivalue: false,
    format: proc { |node| IsoToSolrFormat.temporal_display_str(node, true) }
  },
  temporal_duration: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    multivalue: false,
    reduce: IsoToSolrFormat::REDUCE_TEMPORAL_DURATION,
    format: IsoToSolrFormat::TEMPORAL_DURATION
  },
  temporal: {
    xpaths: ['.//gmd:EX_TemporalExtent'],
    multivalue: true,
    format: proc { |node| IsoToSolrFormat.temporal_index_str node }
  },
  sensors: {
    xpaths: ['.//gmi:acquisitionInformation/gmi:MI_AcquisitionInformation/gmi:instrument/gmi:MI_Instrument/gmi:citation/gmd:CI_Citation/gmd:title/gco:CharacterString'],
    multivalue: true
  },
  source: {
    xpaths: [''],
    default_values: ['ADE'],
    multivalue: false
  },
  facet_data_center: {
      xpaths: [''],
      default_values: ["#{long_name} | #{short_name}"],
      multivalue: false
  },
  facet_spatial_coverage: {
    xpaths: ['.//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox'],
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
    format: IsoToSolrFormat::FACET_TEMPORAL_DURATION,
    multivalue: true
  },
  facet_author: {
    xpaths: [".//gmd:CI_ResponsibleParty[./gmd:role/gmd:CI_RoleCode[@codeListValue='principalInvestigator']]/gmd:individualName/gco:CharacterString"],
    multivalue: true,
    unique: true
  }
}