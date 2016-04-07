# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nasa_apod/version'

Gem::Specification.new do |spec|
  spec.name          = "nasa_apod"
  spec.version       = NasaApod::VERSION
  spec.authors       = ["Gabe Dominguez"]
  spec.email         = ["gabe.p.dominguez@gmail.com"]
  spec.summary       = %q{Ruby wrapper for NASA's Astronomy Picture of the Day API}
  spec.description   = %q{A Ruby gem for consuming the NASA Astronomy Picture of the Day API. }
  spec.homepage      = "https://github.com/gdomingu/nasa_apod"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency 'rspec', "~> 3.3"
  spec.add_development_dependency 'httparty', "~> 0.13"

  spec.add_runtime_dependency 'httparty', "~> 0.13"
end
