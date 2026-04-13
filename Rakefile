# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files =
    if ARGV.size > 1
      FileList[*ARGV[1..]]
    else
      FileList["test/**/*_test.rb"]
    end
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test]
