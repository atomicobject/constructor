require 'rubygems'
require 'bundler/setup'
Bundler::GemHelper.install_tasks
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run specs'
task :default => :spec

desc 'Run constructor specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['specs/*_spec.rb']
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