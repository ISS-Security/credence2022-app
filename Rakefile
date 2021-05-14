# frozen_string_literal: true

# rubocop:disable Style/HashSyntax
require 'rake/testtask'

task :print_env do
  puts "Environment: #{ENV.fetch('RACK_ENV') || 'development'}"
end

desc 'Run application console (pry)'
task :console => :print_env do
  sh 'pry -r ./spec/test_load_all'
end

desc 'Rake all the Ruby'
task :style do
  sh 'rubocop .'
end

namespace :run do
  # Run in development mode
  desc 'Run Web App in development mode'
  task :dev do
    sh 'rackup -p 9292'
  end
end
# rubocop:enable Style/HashSyntax
