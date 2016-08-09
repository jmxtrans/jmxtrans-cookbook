#!/usr/bin/env rake
require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %w(style unit)

# Setup Rubocop tasks; rubocop and rubocop:autocorrect
RuboCop::RakeTask.new

# Setup foodcritic task
FoodCritic::Rake::LintTask.new do |foodcritic|
    foodcritic.options = { tags: %w(~FC003 ~FC059), fail_tags: ['correctness'] }
end

# A task that runs foodcritic and rubocop
desc 'Run the style tests'
task :style do
    Rake::Task['foodcritic'].invoke
    Rake::Task['rubocop'].invoke
end

# Setup the ChefSpec Unit tests task
namespace :unit do
    desc 'Run rspec and chefspec tests'
    RSpec::Core::RakeTask.new do |rspec|
        rspec.pattern = 'spec/**/*_spec.rb'
    end
end

# Use the unit task to execute all unit tests
desc 'Run all unit tests'
task :unit do
    Rake.application.in_namespace(:unit) { |unittests| unittests.tasks.each(&:invoke) }
end
