# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "constructor/version"

Gem::Specification.new do |s|
  s.name        = "constructor"
  s.version     = Constructor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Atomic Object"]
  s.email       = ["github@atomicobject.com"]
  s.homepage    = "http://atomicobject.github.com/constructor"
  s.summary     = %q{Declarative named-argument object initialization.}
  s.description = %q{Declarative means to define object properties by passing a hash to the constructor, which will set the corresponding ivars.}

  s.rubyforge_project = "constructor"

  s.files         = `git ls-files` .split("\n").reject {|f| f =~ /homepage/}
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec", ">= 1", "<= 1.3.1"
  s.add_development_dependency "rake", ">= 0.8.7"
end
