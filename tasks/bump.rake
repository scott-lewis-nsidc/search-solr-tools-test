# frozen_string_literal: true

require 'bump'

namespace :bump do
  desc 'Bump to a pre-release version'
  task :pre do
    bump_and_push('pre')
  end

  desc 'Bump to a patch release version'
  task :patch do
    bump_and_push('patch')
  end

  desc 'Bump to a minor release version'
  task :minor do
    bump_and_push('minor')
  end

  desc 'Bump to a major release version'
  task :major do
    bump_and_push('major')
  end

  desc 'Bump to a manually-specified version (in x.x.x... form; do not add initial "v")'
  task :manual, [:ver] do |_t, args|
    bump_and_push(args[:ver])
  end

  def bump_and_push(version)
    sh %(gem bump --version #{args[:version]})
    update_changelog
    sh %(git add #{version_rb} Gemfile.lock CHANGELOG.md)
    sh %(git commit -m "Bumping version to #{current_version}")
    sh %(gem tag --push)
  end

  def version_rb
    File.join(EdbModel.root, 'lib', 'search_solr_tools', 'version.rb')
  end

  def current_version
    Bump::Bump.current
  end

  def update_changelog
    sh %(sed -i "s/^## Unreleased$/## v#{current_version} (#{date})/" #{changelog_md})
  end
end