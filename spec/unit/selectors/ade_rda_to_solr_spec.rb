require 'iso_to_solr'

describe 'RDA ISO to Solr converter' do

  fixture = Nokogiri.XML File.open('spec/unit/fixtures/rda_iso.xml')
  iso_to_solr = IsoToSolr.new(:rda)
  solr_doc = iso_to_solr.translate fixture

  test_expectations = [
    {
      title: 'should grab the correct title',
      xpath: "/doc/field[@name='title']",
      expected_text: 'Daily Northern Hemisphere Sea Level Pressure Grids, continuing from 1899'
    },
    {
      title: 'should grab the correct summary',
      xpath: "/doc/field[@name='summary']",
      expected_text: 'The 5-degree latitude/longitude grids contained in this dataset make up the longest continuous set of ' +
      'daily gridded Northern Hemisphere sea-level pressure data in the DSS archive. For more information, ' +
      'see the documentation [http://rda.ucar.edu/datasets/ds010.0/docs/] about original data points.'
    },
    {
      title: 'should grab the correct data center',
      xpath: "/doc/field[@name='data_centers']",
      expected_text: 'Data Support Section, Computational and Information Systems Laboratory, National Center for Atmospheric Research, University Corporation for Atmospheric Research'
    },
    {
      title: 'should grab the correct get data link',
      xpath: "/doc/field[@name='dataset_url']",
      expected_text: 'http://rda.ucar.edu/datasets/ds010.0/'
    },
    {
      title: 'should grab the correct updated date',
      xpath: "/doc/field[@name='last_revision_date']",
      expected_text: '2014-01-21T00:00:00Z'
    },
    {
      title: 'should grab the correct source',
      xpath: "/doc/field[@name='source']",
      expected_text: 'ADE'
    },
    {
      title: 'should grab the correct spatial display bounds',
      xpath: "/doc/field[@name='spatial_coverages']",
      expected_text: '15 -180 90 180'
    },
    {
      title: 'should grab the correct spatial bounds',
      xpath: "/doc/field[@name='spatial']",
      expected_text: '-180 15 180 90'
    },
    {
      title: 'should grab the correct temporal coverage',
      xpath: "/doc/field[@name='temporal_coverages']",
      expected_text: '1899-01-01,2014-01-21'
    },
    {
      title: 'should grab the correct temporal range',
      xpath: "/doc/field[@name='temporal']",
      expected_text: '18.990101 20.140121'
    }
  ]

  test_expectations.each do |expectation|
    it expectation[:title] do
      solr_doc.xpath(expectation[:xpath]).text.strip.should eql expectation[:expected_text]
    end
  end

end
