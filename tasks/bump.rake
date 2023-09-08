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
    p "------ 1 ------"
    sh %(git status)
    p "------ 2 ------"
    sh %(gem bump --version #{version})
    p "------ 3 ------"
    update_changelog
    p "------ 4 ------"
    sh %(bundle list > /dev/null)
    sh %(git add #{version_rb} Gemfile.lock #{changelog_md})
    p "------ 5 ------"
    sh %(git status)
    p "------ 6 ------"
    sh %(git commit -m "Bumping version to #{current_version}")
    p "------ 7 ------"
    sh %(git status)
    p "------ 8 ------"
    sh %(bundle list > /dev/null)
    p "------ 8A ------"
    sh %(git status)
    p "------ 8B ------"
    sh %(gem tag --push)
    p "------ 9 ------"
  end

  def version_rb
    File.join(root, 'lib', 'search_solr_tools', 'version.rb')
  end

  def changelog_md
    File.join(root, 'CHANGELOG.md')
  end

  def current_version
    Bump::Bump.current
  end

  def update_changelog
    date = Time.now.strftime('%Y-%m-%d')
    sh %(sed -i "s/^## Unreleased$/## v#{current_version} (#{date})/" #{changelog_md})
  end

  # The very top of the working directory.
  def root
    spec.gem_dir
  end

  def spec
    Gem::Specification.find_by_name('search_solr_tools')
  end
end