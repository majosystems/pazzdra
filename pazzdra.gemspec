# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pazzdra/version'

Gem::Specification.new do |spec|
  spec.name          = "pazzdra"
  spec.version       = Pazzdra::VERSION
  spec.authors       = ["takashi.akagi"]
  spec.email         = ["nisyu@mac.com"]
  spec.summary       = %q{PAZZRU & DRAGONS calc.}
  spec.description   = %q{PAZZRU & DRAGONS calc.}
  spec.homepage      = "https://github.com/majosystems/pazzdra"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
