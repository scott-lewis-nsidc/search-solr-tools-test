require 'selectors/helpers/iso_to_solr'

describe 'CISL ISO to Solr converter' do

  fixture = Nokogiri.XML File.open('spec/unit/fixtures/cisl_oai.xml')
  iso_to_solr = IsoToSolr.new(:cisl)
  solr_doc = iso_to_solr.translate fixture

  test_expectations = [
    {
      title: 'should include the correct authoritative id',
      xpath: "/doc/field[@name='authoritative_id']",
      expected_text: 'oai:ACADIS:005f3222-7548-11e2-851e-00c0f03d5b7c'
    },
    {
      title: 'should grab the correct title',
      xpath: "/doc/field[@name='title']",
      expected_text: 'Carbon Isotopic Values of Alkanes Extracted from Paleosols'
    },
    {
      title: 'should grab the correct summary',
      xpath: "/doc/field[@name='summary']",
      expected_text: "Dataset consists of compound specific carbon isotopic values of alkanes\nextracted from paleosols." \
      " Values represent the mean of duplicate\nmeasurements."
    },
    {
      title: 'should grab the correct data center',
      xpath: "/doc/field[@name='data_centers']",
      expected_text: 'Advanced Cooperative Arctic Data and Information Service'
    },
    {
      title: 'should grab the correct author',
      xpath: "/doc/field[@name='authors']",
      expected_text: ''
    },
    {
      title: 'should grab the correct keywords',
      xpath: "/doc/field[@name='keywords']",
      expected_text: 'PALEOSOLSCARBONISOTOPESECOSYSTEM FUNCTIONSBIOGEOCHEMICAL PROCESSES'
    },
    {
      title: 'should grab the correct updated date',
      xpath: "/doc/field[@name='last_revision_date']",
      expected_text: '2015-02-05T00:00:00Z'
    },
    {
      title: 'should grab the correct get data link',
      xpath: "/doc/field[@name='dataset_url']",
      expected_text: 'http://www.aoncadis.org/dataset/id/005f3222-7548-11e2-851e-00c0f03d5b7c.html'
    },
    {
      title: 'should grab the correct spatial display bounds',
      xpath: "/doc/field[@name='spatial_coverages']",
      expected_text: '66.56 -180.0 90.0 180.0'
    },
    {
      title: 'should grab the correct spatial bounds',
      xpath: "/doc/field[@name='spatial']",
      expected_text: '-180.0 66.56 180.0 90.0'
    },
    {
      title: 'should calculate the correct spatial area',
      xpath: "/doc/field[@name='spatial_area']",
      expected_text: '23.439999999999998'
    },
    {
      title: 'should grab the correct temporal coverage',
      xpath: "/doc/field[@name='temporal_coverages']",
      expected_text: '2011-01-29,2014-04-27'
    },
    {
      title: 'should grab the correct temporal range',
      xpath: "/doc/field[@name='temporal']",
      expected_text: '20.110129 20.140427'
    },
    {
      title: 'should calculate the correct temporal duration',
      xpath: "/doc/field[@name='temporal_duration']",
      expected_text: '1184'
    },
    {
      title: 'should grab the correct source',
      xpath: "/doc/field[@name='source']",
      expected_text: 'ADE'
    },
    {
      title: 'should grab the correct data center facet',
      xpath: "/doc/field[@name='facet_data_center']",
      expected_text: 'Advanced Cooperative Arctic Data and Information Service | ACADIS Gateway'
    },
    {
      title: 'should grab the correct spatial scope facet',
      xpath: "/doc/field[@name='facet_spatial_scope']",
      expected_text: 'Between 1 and 170 degrees of latitude change | Regional'
    },
    {
      title: 'should grab the correct temporal duration facet',
      xpath: "/doc/field[@name='facet_temporal_duration']",
      expected_text: '1+ years'
    }
  ]

  test_expectations.each do |expectation|
    it expectation[:title] do
      solr_doc.xpath(expectation[:xpath]).text.strip.should eql expectation[:expected_text]
    end
  end
end
