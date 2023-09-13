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
end

# def bump_and_push(version)
#   sh %(gem bump --version #{version})
#   update_changelog
#   sh %(bundle list > /dev/null)
#   sh %(git add #{version_rb} Gemfile.lock #{changelog_md})
#   sh %(git commit -m "Bumping version to #{current_version}")
#   sh %(gem tag --push)
# end

def bump_and_push(version)
  update_changelog(version)
  Bump::Bump.run(version, tag: true, commit: true, changelog: false)

  sh %(git push --tags)
end

def version_rb
  File.join(root, 'lib', 'search_solr_tools_test', 'version.rb')
end

def changelog_md
  File.join(root, 'CHANGELOG.md')
end

def update_changelog(version)
  date = Time.now.strftime('%Y-%m-%d')
  next_ver = Bump::Bump.next_version(version)
  sh %(sed -i "s/^## Unreleased$/## v#{next_ver} (#{date})/" #{changelog_md})
  sh %(git add #{changelog_md})
end

# The very top of the working directory.
def root
  spec.gem_dir
end

def spec
  Gem::Specification.find_by_name('search_solr_tools_test')
end
