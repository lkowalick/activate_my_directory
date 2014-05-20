# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activate_my_directory/version'

Gem::Specification.new do |spec|
  spec.name          = "activate_my_directory"
  spec.version       = ActivateMyDirectory::VERSION
  spec.authors       = ["Ryan Kowalick"]
  spec.email         = ["rkowalick@covermymeds.com"]
  spec.summary       = %q{Tools for ActiveDirectory authentication}
  spec.description   = %q{This gems allows you to easily authenticate with ActiveDirectory and determine if a user is a member of a certain group.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_dependency "active_directory"
end
