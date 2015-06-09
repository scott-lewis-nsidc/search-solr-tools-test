# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

# no need for tests or dev files like .rubocop.yml to be packaged with the gem
gem_files = %(.ruby-version CHANGELOG.md COPYING README.md config/ lib/ search_solr_tools.gemspec)

Gem::Specification.new do |spec|
  spec.name          = 'search_solr_tools'
  spec.version       = SearchSolrTools::VERSION
  spec.authors       = ['Chris Chalstrom', 'Michael Brandt', 'Jonathan Kovarik', 'Luis Lopez', 'Stuart Reed']
  spec.email         = ['cchalstr@nsidc.org', 'mbrandt@colorado.edu', 'kovarik@nsidc.org', 'luis.lopezespinosa@colorado.edu', 'stuart.reed@colorado.edu']
  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = ''
  spec.license       = 'GNU GPL Version 3'

  spec.files         = `git ls-files -z #{gem_files}`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.required_ruby_version = File.read(File.expand_path('../.ruby-version', __FILE__)).strip

  spec.add_runtime_dependency 'gi_cat_driver', '~> 0.3'
  spec.add_runtime_dependency 'iso8601', '~> 0.8'
  spec.add_runtime_dependency 'multi_json', '~> 1.11'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  spec.add_runtime_dependency 'rest-client', '~> 1.6'
  spec.add_runtime_dependency 'rgeo', '~> 0.3'
  spec.add_runtime_dependency 'rgeo-geojson', '~> 0.3'
  spec.add_runtime_dependency 'rsolr', '~> 1.0'
  spec.add_development_dependency 'guard', '~> 2.12'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  # spec.add_development_dependency 'pry-byebug', '~> 3.1'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop', '~> 0.32'
  spec.add_development_dependency 'webmock', '~> 1.13'
end