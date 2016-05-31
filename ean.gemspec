# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ean/version'

Gem::Specification.new do |spec|
  spec.name          = "ean"
  spec.version       = EAN::VERSION
  spec.authors       = ["Pascal Belloncle (nano RAILS)"]
  spec.email         = ["psq@nanorails.com"]
  spec.description   = %q{Provide validation/generation for UPC/EAN/GTIN numbers}
  spec.summary       = %q{Provide validation/generation for UPC/EAN/GTIN numbers}
  spec.homepage      = "https://github.com/reverbdotcom/ean"
  spec.license       = "The MIT License"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
