require 'rubygems'
require 'bundler/setup'
Bundler.setup
Bundler::GemHelper.install_tasks
begin
  require 'rdoc/task'
  require 'rspec/core/rake_task'
rescue Exception => e
  puts "FAILED to require RSpec stuff: #{e.message}"
  puts e.backtrace
  puts
  puts "!! You might need to: bundle install"
  exit
end

desc 'Default: run specs'
task :default => :spec

desc 'Run constructor specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['-c', '-f', 's']
end

desc 'Generate documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'constructor'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('History.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
