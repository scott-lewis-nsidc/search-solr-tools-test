require 'spec_helper'
require 'pry-byebug'

describe SearchSolrTools::Translators::EolToSolr do
  before :all do
    @translator = described_class.new
    @thredds_metadata = Nokogiri::XML(File.open(File.expand_path('../../../unit/fixtures/eol_thredds_106_295.thredds.xml', __FILE__)))
    @dataset_metadata = Nokogiri::XML(File.open(File.expand_path('../../../unit/fixtures/eol_thredds_106_295.metadata.xml', __FILE__)))
  end

  context 'When translating an EOL THREDDS dataset record' do
    before :all do
      @solr_insert = @translator.translate(@thredds_metadata, @dataset_metadata)
    end

    it 'populates title' do
      expect(@solr_insert['title']).to eql 'An Analysis of the Carbon Balance of the Arctic Basin from 1997 to 2006'
    end

    it 'populates auth_id' do
      expect(@solr_insert['authoritative_id']).to eql 'ucar.ncar.eol.dataset.106_295'
    end

    it 'populates data_centers' do
      expect(@solr_insert['data_centers']).to eql 'UCAR NCAR - Earth Observing Laboratory'
    end

    it 'populates facets_data_center' do
      expect(@solr_insert['facet_data_center']).to eql 'UCAR NCAR - Earth Observing Laboratory | UCAR NCAR EOL'
    end

    # TODO: fixture!
    it 'populates summary' do
      expect(@solr_insert['summary']).to eql " These data sets are the results of a model-data analysis of the contemporary C balance of the Arctic system. CO2 and CH4 exchange between the terrestrial ecosystems of the basin and the atmosphere, along with the export of dissolved organic C (DOC) to the Arctic Ocean, were estimated using the Terrestrial Ecosystem Model (TEM). The TEM considers the effects of a number of factors on its simulations of C dynamics including changes in atmospheric CO2, tropospheric ozone, nitrogen deposition, climate, and disturbance/land use including fire, forest harvest, and agricultural establishment/abandonment. We used the methane dynamics module of TEM (MDM-TEM) to estimate the exchange of CH4 with atmosphere of both wetlands. The MDM-TEM considers the effects of a number of factors on its simulations of CH4 dynamics including the area of wetlands, fluctuations in the water table of wetlands, temperature, and labile carbon inputs into the soil solution derived from the net primary production (NPP) estimates of TEM.\n The results of these simulations were compared with estimates of CO2 and CH4 exchange from atmospheric inversion models and with observations of terrestrial C export from Arctic watersheds. The simulated transfer of land-based C to the Arctic Ocean was compared against estimates based on a sampling of DOC export from major Arctic rivers (McClelland et al., 2008). We summarize our estimates of surface-atmosphere CO2 and CH4 exchange for the land and ocean area matching the three high-latitude regions defined in the Transcom 3 model experiments (Gurney et al., 2002), namely the Boreal North America, Boreal Asia and Northern Ocean regions. "
    end

    it 'populates temporal_coverages' do
      expect(@solr_insert['temporal_coverages']).to eql ['1996-12-31,2006-12-31']
    end

    it 'populates temporal_duration' do
      expect(@solr_insert['temporal_duration']).to be 3652
    end

    it 'populates temporal' do
      expect(@solr_insert['temporal']).to eql ['19.961231 20.061231']
    end

    it 'populates facet_temporal_duration' do
      expect(@solr_insert['temporal_duration']).to be 3652
    end

    it 'populates last_revision_date' do
      expect(@solr_insert['last_revision_date']).to eql '2010-02-01T04:34:54Z'
    end

    it 'populates source' do
      expect(@solr_insert['source']).to eql 'ADE'
    end

    it 'populates keywords' do
      expect(@solr_insert['keywords']).to eql ['Arctic', 'Models/Analyses']
    end

    it 'populates authors' do
      expect(@solr_insert['authors']).to eql 'A. Dave McGuire, Daniel J Hayes, David W Kicklighter, Manfredi Manizza, Qianlai Zhuang, Min Chen, Mick Follows, Kevin Gurney , James McClelland, Jerry M. Melillo, Bruce J. Peterson, Ronald Prinn'
    end

    it 'populates dataset_url' do
      expect(@solr_insert['dataset_url']).to eql 'http://data.eol.ucar.edu/codiac/dss/id=106.295'
    end

    it 'populates facet_spatial_coverage' do
      expect(@solr_insert['facet_spatial_coverage']).to be false
    end

    it 'populates facet_spatial_scope' do
      expect(@solr_insert['facet_spatial_scope']).to eql 'Between 1 and 170 degrees of latitude change | Regional'
    end

    it 'populates spatial_coverages' do
      expect(@solr_insert['spatial_coverages']).to eql '45.0 -180.0 83.5 179.5'
    end

    it 'populates_spatial_area' do
      expect(@solr_insert['spatial_area']).to be 38.5
    end

    it 'populates spatial' do
      expect(@solr_insert['spatial']).to eql '-180.0 45.0 179.5 83.5'
    end
  end

  describe '#eol_dataset_url' do
    it 'extracts the url' do
      expect(@translator.eol_dataset_url(@dataset_metadata)).to eql 'http://data.eol.ucar.edu/codiac/dss/id=106.295'
    end
    it 'returns nil if there is no URL' do
      expect(@translator.eol_dataset_url(Nokogiri::XML('<test />'))).to be nil
    end
  end

  describe '#parse_eol_authors' do
    it 'removes the EOL author email address' do
      expect(@translator.parse_eol_authors('Fros T Snowman, snow AT man dot com')).to eql 'Fros T Snowman'
    end

    it 'leaves normal contact strings alone' do
      expect(@translator.parse_eol_authors('John M Smith')).to eql 'John M Smith'
    end
  end

  describe '#get_time_coverages' do
    it 'handles multiple timeCoverage elements' do
      document = %(<TEST xmlns="TEST">
                    <timeCoverage>
                      <start>1996-12-31T18:01:00Z</start>
                      <end>1997-12-31T18:01:00Z</end>
                    </timeCoverage>
                    <timeCoverage>it's def
                      <start>2000-12-31T18:01:00Z</start>
                      <end>2007-12-31T18:01:00Z</end>
                    </timeCoverage>
                                    )
      expect(@translator.get_time_coverages(Nokogiri::XML(document))).to eql [{ 'start' => '1996-12-31T18:01:00Z', 'end' => '1997-12-31T18:01:00Z' },
                                                                              { 'start' => '2000-12-31T18:01:00Z', 'end' => '2007-12-31T18:01:00Z' }]
    end
  end

  describe '#open_xml_document' do
    before :all do
      @doc_url = 'http://some.api.for.data.xml'
      stub_request(:get, @doc_url).to_return(body: File.open(File.expand_path('../../../unit/fixtures/eol_thredds_106_295.thredds.xml', __FILE__)), status: 200)
    end

    it 'opens an xml document given a URL' do
      expect(@translator.open_xml_document(@doc_url)).to be_kind_of(Nokogiri::XML::Document)
    end
  end

  describe '#spatial_coverage_to_spatial_area' do
    it 'Returns spatial coverage value' do
      value = @translator.spatial_coverage_to_spatial_area(north: 50, east: 40, south: 30, west: 20)
      expect(value).to be 20
    end
    it 'Returns nil for an invalid hash' do
      value = @translator.spatial_coverage_to_spatial_area(not: 0, a: 1, spatial: 2)
      expect(value).to be nil
    end
  end

  describe '#parse_geospatial_coverages' do
    before :each do
      @doc = Nokogiri::XML(%(
        <TEST xmlns="TEST">
          <geospatialCoverage>
            <northsouth>
              <start>-90</start>
              <size>180</size>
            </northsouth>
            <eastwest>
              <start>-180</start>
              <size>360</size>
            </eastwest>
          </geospatialCoverage>
      ))
    end

    it 'returns the expected coverages' do ## TODO: Refactor to modify XML doc rather than recreating.
      expect(@translator.parse_geospatial_coverages(@doc)).to eql(east: 180.0, west: -180.0, north: 90.0, south: -90.0)
    end

    it 'parses bounds that eastwardly cross the date line' do
      @doc.xpath('//xmlns:eastwest/xmlns:start/text()')[0].content = -130
      @doc.xpath('//xmlns:eastwest/xmlns:size/text()')[0].content = 340
      expect(@translator.parse_geospatial_coverages(@doc)).to eql(east: -150.0, west: -130.0, north: 90.0, south: -90.0)
    end

    it 'parses bounds that westwardly cross the date line' do
      @doc.xpath('//xmlns:eastwest/xmlns:start/text()')[0].content = -190
      @doc.xpath('//xmlns:eastwest/xmlns:size/text()')[0].content = 50
      expect(@translator.parse_geospatial_coverages(@doc)).to eql(east: -140.0, west: 170.0, north: 90.0, south: -90.0)
    end
  end
end
