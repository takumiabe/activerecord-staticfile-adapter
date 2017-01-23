# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/staticfile/adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-staticfile-adapter"
  spec.version       = Activerecord::Staticfile::Adapter::VERSION
  spec.authors       = ["Takumi Abe"]
  spec.email         = ["abe@engraphia.com"]

  spec.summary       = %q{ActiveRecord::Adapters for static file e.g. yaml, csv, ...}
  spec.description   = %q{ActiveRecord::Adapters for static file e.g. yaml, csv, ...}
  spec.homepage      = "https://github.com/takumiabe/activerecord-staticfile-adapter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "activerecord", "~> 4.2.0"
end
