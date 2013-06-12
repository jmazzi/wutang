# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wutang/version'

Gem::Specification.new do |spec|
  spec.name          = "wutang"
  spec.version       = Wutang::VERSION
  spec.authors       = ["Justin Mazzi"]
  spec.email         = ["jmazzi@gmail.com"]
  spec.description   = %q{An experimental command line password manager}
  spec.summary       = %q{An experimental command line password manager}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
