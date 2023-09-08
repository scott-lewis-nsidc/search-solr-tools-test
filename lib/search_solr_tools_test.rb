# frozen_string_literal: true

require_relative 'search_solr_tools_test/config/environments'
require_relative 'search_solr_tools_test/version'

require_relative 'search_solr_tools_test/helpers/harvest_status'
require_relative 'search_solr_tools_test/errors/harvest_error'

%w[harvesters translators].each do |subdir|
  Dir[File.join(__dir__, 'search_solr_tools_test', subdir, '*.rb')].each { |file| require file }
end