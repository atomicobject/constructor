require 'rubygems'
require 'bundler/setup'
Bundler::GemHelper.install_tasks
begin
  require 'rake/rdoctask'
  require 'spec/rake/spectask'
rescue
  puts "You need to: bundle install"
end

desc 'Default: run specs'
task :default => :spec

desc 'Run constructor specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '-c -f s'
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