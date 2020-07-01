require_relative './search_solr_tools/config/environments'
require_relative './search_solr_tools/version'

%w( helpers selectors harvesters translators ).each do |subdir|
  puts File.join(__dir__, 'search_solr_tools', subdir)
  Dir[File.join(__dir__, 'search_solr_tools', subdir, '*.rb')]
      .reject{ |f| f.include? 'selectors.rb'}  # files that need this will have it required
      .each do |file|
    puts file
    require file
  end
end
