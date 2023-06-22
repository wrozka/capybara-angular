# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/angular/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-angular"
  spec.version       = Capybara::Angular::VERSION
  spec.authors       = ["Pawel Pierzchala"]
  spec.email         = ["pawelpierzchala@gmail.com"]
  spec.description   = %q{Capybara API that knows how to wait for Angular in end to end specs}
  spec.summary       = %q{Stable Capybara API for AngularJS applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.7"

  spec.add_dependency 'capybara', '>= 2.5.0'

  spec.add_development_dependency "bundler", "> 1.17", "< 3"
  spec.add_development_dependency "rails", "> 5.2", "< 7.1"
  spec.add_development_dependency "poltergeist"
  spec.add_development_dependency "puma", "< 6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop_challenger"
  spec.add_development_dependency "simplecov"
end
