require 'webmock/rspec'
require 'usgs_harvester'

describe UsgsHarvester do
  before :each do
    @harvester = described_class.new 'integration'
  end

  it 'should retrieve records from the USGS CSW url' do
    stub_request(:get, 'https://www.sciencebase.gov/catalog/item/527cf4ede4b0850ea05182ee/csw?ElementSetName=full&TypeNames=&constraint=%253CFilter%2520xmlns:ogc=%2522http://www.opengis.net/ogc%2522%2520xmlns:gml=%2522http://www.opengis.net/gml%2522%2520xmlns:apiso=%2522http://www.opengis.net/cat/csw/apiso/1.0%2522%253E%253Cogc:BBOX%253E%253CPropertyName%253Eapiso:BoundingBox%253C/PropertyName%253E%253Cgml:Envelope%253E%253Cgml:lowerCorner%253E-180%252045%253C/gml:lowerCorner%253E%253Cgml:upperCorner%253E180%252090%253C/gml:upperCorner%253E%253C/gml:Envelope%253E%253C/ogc:BBOX%253E%253C/Filter%253E&maxRecords=10&outputFormat=application/xml&outputSchema=http://www.isotc211.org/2005/gmd&request=GetRecords&resultType=results&service=CSW&startPosition=1&version=2.0.2')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: '<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd"><foo/></gmd:MD_Metadata>')
    @harvester.get_results_from_usgs(1).first.first_element_child.to_xml.should eql('<foo/>')
  end

  describe 'Adding documents to Solr' do
    it 'constructs an xml document with <doc> children' do
      stub_request(:get, 'https://www.sciencebase.gov/catalog/item/527cf4ede4b0850ea05182ee/csw?ElementSetName=full&TypeNames=&constraint=%253CFilter%2520xmlns:ogc=%2522http://www.opengis.net/ogc%2522%2520xmlns:gml=%2522http://www.opengis.net/gml%2522%2520xmlns:apiso=%2522http://www.opengis.net/cat/csw/apiso/1.0%2522%253E%253Cogc:BBOX%253E%253CPropertyName%253Eapiso:BoundingBox%253C/PropertyName%253E%253Cgml:Envelope%253E%253Cgml:lowerCorner%253E-180%252045%253C/gml:lowerCorner%253E%253Cgml:upperCorner%253E180%252090%253C/gml:upperCorner%253E%253C/gml:Envelope%253E%253C/ogc:BBOX%253E%253C/Filter%253E&maxRecords=10&outputFormat=application/xml&outputSchema=http://www.isotc211.org/2005/gmd&request=GetRecords&resultType=results&service=CSW&startPosition=1&version=2.0.2')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: File.open('spec/unit/fixtures/usgs_iso.xml'), headers: {})

      entries = @harvester.get_results_from_usgs(1)
      @harvester.get_docs_with_translated_entries_from_usgs(entries).first.root.first_element_child.name.should eql('doc')
    end

    it 'Issues a request to update Solr with data' do
      stub_request(:post, 'http://integration.search-solr.apps.int.nsidc.org:8983/solr/nsidc_oai/update?commit=true')
        .with(body: Nokogiri.XML('<add><foo></add>').to_xml,
              headers: {
                'Accept' => '*/*; q=0.5, application/xml',
                'Accept-Encoding' => 'gzip, deflate',
                'Content-Length' => '44',
                'Content-Type' => 'text/xml; charset=utf-8',
                'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: 'success', headers: {})

      @harvester.insert_solr_doc(Nokogiri.XML('<add><foo></add>')).should eql(true)
    end
  end
end
