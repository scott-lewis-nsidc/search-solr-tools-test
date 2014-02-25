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
      prefix: '',
      repo_dir: '/disks/integration/san/INTRANET/REPO/nsidc_search_solr/',
      port: '9283'
  }

  SOLR_ENVIRONMENTS = {
      development: {
          setup_dir: '/opt/solr/dev',
          deployment_target: '~/solr_deploy/',
          run_dir: '/opt/solr/dev',
          collection_name: 'collection1',
          collection_path: 'solr',
          prefix: 'sudo',
          port: '8983',
          repo_dir: '~/solr_repo/',
          oai_url: 'http://liquid.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
          nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
          echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.iso19115',
          ices_url: 'http://geo.ices.dk/geonetwork/srv/en/csw',
          gi_cat_csw_url: 'http://liquid.colorado.edu:11380/api/gi-cat/services/cswiso',
          gi_cat_url: 'http://liquid.colorado.edu:11380/api/gi-cat',
          host: 'localhost'
      },
      integration: COMMON.clone.merge({
                                             deployment_target: '/disks/integration/live/apps/nsidc-open-search-solr/',
                                             oai_url: 'http://liquid.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
                                             nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
                                             echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.iso19115',
                                             ices_url: 'http://geo.ices.dk/geonetwork/srv/en/csw',
                                             gi_cat_csw_url: 'http://liquid.colorado.edu:11380/api/gi-cat/services/cswiso',
                                             gi_cat_url: 'http://liquid.colorado.edu:11380/api/gi-cat',
                                             host: 'liquid.colorado.edu'
                                         }),
      qa: COMMON.clone.merge({
                                    deployment_target: '/disks/qa/live/apps/nsidc-open-search-solr/',
                                    oai_url: 'http://brash.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
                                    nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
                                    echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.iso19115',
                                    ices_url: 'http://geo.ices.dk/geonetwork/srv/en/csw',
                                    gi_cat_csw_url: 'http://brash.colorado.edu:11380/api/gi-cat/services/cswiso',
                                    gi_cat_url: 'http://brash.colorado.edu:11380/api/gi-cat',
                                    host: 'brash.colorado.edu'
                                }),
      staging: COMMON.clone.merge({
                                         deployment_target: '/disks/staging/live/apps/nsidc-open-search-solr/',
                                         oai_url: 'http://freeze.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
                                         nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
                                         echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.iso19115',
                                         ices_url: 'http://geo.ices.dk/geonetwork/srv/en/csw',
                                         gi_cat_csw_url: 'http://freeze.colorado.edu:11380/api/gi-cat/services/cswiso',
                                         gi_cat_url: 'http://freeze.colorado.edu:11380/api/gi-cat',
                                         host: 'freeze.colorado.edu'
                                     }),
      production: COMMON.clone.merge({
                                         deployment_target: '/disks/production/live/apps/nsidc-open-search-solr/',
                                         oai_url: 'http://frozen.colorado.edu:11580/api/dataset/2/oai?verb=ListRecords&metadata_prefix=iso',
                                         nodc_url: 'http://data.nodc.noaa.gov/geoportal/csw',
                                         echo_url: 'https://api.echo.nasa.gov/catalog-rest/echo_catalog/datasets.iso19115',
                                         ices_url: 'http://geo.ices.dk/geonetwork/srv/en/csw',
                                         gi_cat_csw_url: 'http://frozen.colorado.edu:11380/api/gi-cat/services/cswiso',
                                         gi_cat_url: 'http://frozen.colorado.edu:11380/api/gi-cat',
                                         host: 'frozen.colorado.edu'
                                     })
  }
end
