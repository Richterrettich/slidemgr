# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'slidemgr'
  spec.version       = CommandRouter::VERSION
  spec.authors       = ['Rene Richter']
  spec.email         = ['Richterrettich@gmail.com']

  spec.summary       = 'A little programm to generate layouts for reveal.js presentations'
  spec.description   = 'A little programm to generate layouts for reveal.js presentations'
  spec.homepage      =  'https://github.com/Richterrettich/slidemgr'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = 'slidemgr'
  spec.require_paths = ["lib"]

  spec.license = "GPLv3"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_runtime_dependency 'thor', '~> 0.19.1'
  spec.add_runtime_dependency 'git', '~> 1.2.9.1'
  spec.add_runtime_dependency 'launchy', '~> 2.4.3'

end
