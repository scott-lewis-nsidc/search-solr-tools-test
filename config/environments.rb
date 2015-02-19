# configuration to work with solr locally, or on integration/qa/staging/prod
module SolrEnvironments
  def self.[](key)
    key_sym = (key || 'development').to_sym
    SOLR_ENVIRONMENTS[key_sym]
  end

  def self.jar_file
    'start.jar'
  end

  def self.pid_file
    'solr.pid'
  end

  private

  COMMON = {
    setup_dir: './solr/example',
    collection_name: 'nsidc_oai',
    collection_path: 'solr',
    auto_suggest_collection_name: 'auto_suggest',
    prefix: '',
    repo_dir: '/disks/integration/san/INTRANET/REPO/nsidc_search_solr/',
    port: '8983',
    nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
    echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.echo10',
    ices_url: 'http://geo.ices.dk/geonetwork/srv/en/csw',
    bcodmo_url: 'http://www.bco-dmo.org/nsidc/arctic-deployments.json',
    usgs_url: 'https://www.sciencebase.gov/catalog/item/527cf4ede4b0850ea05182ee/csw',
    cisl_url: 'https://www.aoncadis.org/oai/repository',
    pdc_url: 'http://www.polardata.ca/oai/provider'
  }

  SOLR_ENVIRONMENTS = {
    local: COMMON.clone.merge(
      prefix: 'sudo',
      oai_url: 'http://liquid.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://integration.nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso', # 'http://localhost:1580/oai?verb=ListIdentifiers&metadata_prefix=iso'
      # nsidc_oai_identifiers_url: 'http://localhost:1580/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://integration.nsidc.org/api/dataset/metadata/',
      # nsidc_dataset_metadata_url: 'http://localhost:1580/',
      nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
      echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.echo10',
      gi_cat_csw_url: 'http://liquid.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://liquid.colorado.edu:11380/api/gi-cat',
      host: 'localhost'
    ),
    dev: COMMON.clone.merge(
      prefix: 'sudo',
      oai_url: 'http://liquid.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://integration.nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso', # 'http://localhost:1580/oai?verb=ListIdentifiers&metadata_prefix=iso'
      # nsidc_oai_identifiers_url: 'http://localhost:1580/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://integration.nsidc.org/api/dataset/metadata/',
      # nsidc_dataset_metadata_url: 'http://localhost:1580/',
      nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
      echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.echo10',
      gi_cat_csw_url: 'http://liquid.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://liquid.colorado.edu:11380/api/gi-cat',
      host: 'dev.search-solr.reedsa.dev.int.nsidc.org'
    ),
    integration: COMMON.clone.merge(
      deployment_target: '/opt/solr-search/',
      oai_url: 'http://liquid.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://integration.nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://integration.nsidc.org/api/dataset/metadata/',
      gi_cat_csw_url: 'http://liquid.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://liquid.colorado.edu:11380/api/gi-cat',
      host: 'integration.search-solr.apps.int.nsidc.org'
    ),
    qa: COMMON.clone.merge(
      deployment_target: '/opt/solr-search/',
      oai_url: 'http://brash.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://qa.nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://qa.nsidc.org/api/dataset/metadata/',
      gi_cat_csw_url: 'http://brash.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://brash.colorado.edu:11380/api/gi-cat',
      host: 'qa.search-solr.apps.int.nsidc.org'
    ),
    staging: COMMON.clone.merge(
      deployment_target: '/opt/solr-search/',
      oai_url: 'http://freeze.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://staging.nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://staging.nsidc.org/api/dataset/metadata/',
      gi_cat_csw_url: 'http://freeze.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://freeze.colorado.edu:11380/api/gi-cat',
      host: 'staging.search-solr.apps.int.nsidc.org'
    ),
    blue: COMMON.clone.merge(
      deployment_target: '/opt/solr-search/',
      oai_url: 'http://frozen.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://nsidc.org/api/dataset/metadata/',
      gi_cat_csw_url: 'http://frozen.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://frozen.colorado.edu:11380/api/gi-cat',
      host: 'blue.search-solr.apps.int.nsidc.org'
    ),
    production: COMMON.clone.merge(
      deployment_target: '/opt/solr-search/',
      oai_url: 'http://frozen.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
      nsidc_oai_identifiers_url: 'http://nsidc.org/api/dataset/metadata/oai?verb=ListIdentifiers&metadata_prefix=iso',
      nsidc_dataset_metadata_url: 'http://nsidc.org/api/dataset/metadata/',
      gi_cat_csw_url: 'http://frozen.colorado.edu:11380/api/gi-cat/services/cswiso',
      gi_cat_url: 'http://frozen.colorado.edu:11380/api/gi-cat',
      host: 'search-solr.apps.int.nsidc.org'
    )
  }
end
