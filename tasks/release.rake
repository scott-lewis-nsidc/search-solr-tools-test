# frozen_string_literal: true

namespace :release do
  desc 'publish the gem to rubygems'
  task :publish do
    sh 'gem release'
  end

  desc 'build the gem'
  task :build do
    sh 'gem build'
  end
end
