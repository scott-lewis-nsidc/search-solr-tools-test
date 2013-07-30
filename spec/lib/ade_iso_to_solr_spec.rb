require 'ade_iso_to_solr'

describe 'CISL ISO to Solr converter' do

  fixture = Nokogiri.XML File.open('spec/fixtures/cisl_iso.xml')
  iso_to_solr = ADEIsoToSolr.new(:cisl)
  solr_doc = iso_to_solr.translate fixture

  it 'should use the default value if none of the xpaths are present' do
    selector = {
          xpaths: ['//gmd:fake1', '//gmd:fake2'],
          default_value: 'default value',
          multivalue: false
      }
    field = iso_to_solr.get_field_values fixture, selector
    field.size.should be == 1
    field[0].should be == 'default value'
  end

  it 'should grab only one node when the multivalue option is false' do
    selector = {
          xpaths: ['//gmd:keyword/gco:CharacterString'],
          multivalue: false
      }
    field = iso_to_solr.get_field_values fixture, selector
    field.size.should be == 1
  end

  it 'should grab all the nodes when the multivalue option is true' do
    selector = {
          xpaths: ['//gmd:keyword/gco:CharacterString'],
          multivalue: true
      }
    field = iso_to_solr.get_field_values fixture, selector
    field.size.should be == 9
    field[0].should be == "\nLand cover\n"
  end

  it 'should fall over the second xpath when the first is not present' do
    selector = {
          xpaths: ['//gmd:YouWontFindThis', '//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString'],
          multivalue: false
      }
    title = iso_to_solr.get_field_values fixture, selector
    title.size.should be == 1
    title[0].should be == 'Carbon Isotopic Values of Alkanes Extracted from Paleosols'
  end

  it 'should format the field using the format key if present' do
    selector = {
          xpaths: ['//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString'],
          multivalue: false,
          format: proc { |x| [x[0].upcase] }
      }
    title = iso_to_solr.get_field_values fixture, selector
    title.size.should be == 1
    title[0].should be == 'CARBON ISOTOPIC VALUES OF ALKANES EXTRACTED FROM PALEOSOLS'
  end

  it 'should return the same value if the format function breaks' do
    selector = {
          xpaths: ['//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString'],
          multivalue: false,
          format: proc { |x| [x[nil].upcase] }
      }
    title = iso_to_solr.get_field_values fixture, selector
    title.size.should be == 1
    title[0].should be == 'Carbon Isotopic Values of Alkanes Extracted from Paleosols'
  end

  # Now the translation

  it 'should grab the correct title' do
    solr_doc.xpath("/doc/field[@name='title']").text.should be ==
    'Carbon Isotopic Values of Alkanes Extracted from Paleosols'
  end

  it 'should grab the correct summary' do
    solr_doc.xpath("/doc/field[@name='summary']").text.should be ==
    "\nDataset consists of compound specific carbon isotopic values of alkanes\nextracted from paleosols." +
    " Values represent the mean of duplicate\nmeasurements.\n"
  end

  it 'should grab the correct data center' do
    solr_doc.xpath("/doc/field[@name='data_centers']").text.should be ==
    'Advanced Cooperative Arctic Data and Information Service'
  end

  it 'should grab the correct get data link' do
    solr_doc.xpath("/doc/field[@name='dataset_url']").text.should be ==
    'http://www.aoncadis.org/dataset/id/005f3222-7548-11e2-851e-00c0f03d5b7c.html'
  end

  it 'should grab the correct updated date' do
    solr_doc.xpath("/doc/field[@name='last_revision_date']").text.should be ==
    '2013-02-13T00:00:00Z'
  end

  it 'should grab the correct source' do
    solr_doc.xpath("/doc/field[@name='source']").text.should be ==
    'ADE'
  end

end