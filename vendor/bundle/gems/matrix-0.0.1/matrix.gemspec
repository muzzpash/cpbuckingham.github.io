# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matrix/version'

Gem::Specification.new do |spec|
  spec.name          = "matrix"
  spec.version       = Matrix::VERSION
  spec.authors       = ["Timo Borreck"]
  spec.email         = ["timo@borreck.org"]
  spec.description   = %q{This gem is under construction.}
  spec.summary       = %q{This gem is under construction.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
