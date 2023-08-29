require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rake/testtask"
require "rdoc/task"
require "yard"

RuboCop::RakeTask.new do |task|
  task.requires << "rubocop-rake"
end

desc "Default: run tests and rubocop."
task default: [:test, :rubocop]

desc "Run luadns unit tests."
Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = Dir["test/**/*_test.rb"]
  t.verbose = true
end

YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end

desc "Run IRB console"
task :console do
  sh "bundle exec irb -r luadns -r ./config/setup"
end
